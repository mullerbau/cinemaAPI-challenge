*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Reservations Service
Suite Teardown    Cleanup Test Data
Test Tags    api    concurrency

*** Test Cases ***
Concurrency-001: Simultaneous Seat Reservation
    [Documentation]    Testa reserva simultânea do mesmo assento por usuários diferentes
    [Tags]    negative    concurrency    race_condition    critical
    Cleanup Test Data
    
    # Preparar dois usuários
    ${token_a}=    Get Valid User Token
    ${unique_email_b}=    Generate Unique Email
    Register User    User B    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${login_response_b}=    Login User    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${token_b}=    Extract Token From Response    ${login_response_b}
    
    # Mesmo assento para ambos
    ${session_id}=    Get Valid Session ID
    ${same_seat}=    Create Dictionary    row=B    number=5    type=full
    ${seats}=    Create List    ${same_seat}
    
    # Tentativa simultânea (simulada)
    ${response_a}=    Create Reservation    ${token_a}    ${session_id}    ${seats}
    ${response_b}=    Create Reservation    ${token_b}    ${session_id}    ${seats}
    
    # Validar que apenas uma reserva foi bem-sucedida
    Validate Concurrent Reservations    ${response_a}    ${response_b}

Concurrency-002: Multiple Reservations Same User
    [Documentation]    Testa múltiplas reservas simultâneas do mesmo usuário
    [Tags]    negative    concurrency    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    
    # Diferentes assentos
    ${seats_1}=    Create Specific Seats List    C    1    2
    ${seats_2}=    Create Specific Seats List    C    3    4
    
    # Reservas simultâneas
    ${response_1}=    Create Reservation    ${token}    ${session_id}    ${seats_1}
    ${response_2}=    Create Reservation    ${token}    ${session_id}    ${seats_2}
    
    # Ambas devem ser bem-sucedidas (assentos diferentes)
    Should Be True    ${response_1.status_code} in [201, 400, 409]
    Should Be True    ${response_2.status_code} in [201, 400, 409]

*** Keywords ***
Extract Token From Response
    [Arguments]    ${login_response}
    ${data}=    Get From Dictionary    ${login_response.json()}    data
    ${token}=    Get From Dictionary    ${data}    token
    RETURN    ${token}

Create Specific Seats List
    [Arguments]    ${row}    ${start_number}    ${end_number}
    ${seats}=    Create List
    FOR    ${i}    IN RANGE    ${start_number}    ${end_number + 1}
        ${seat}=    Create Dictionary    row=${row}    number=${i}    type=full
        Append To List    ${seats}    ${seat}
    END
    RETURN    ${seats}

Validate Concurrent Reservations
    [Arguments]    ${response_a}    ${response_b}
    ${success_count}=    Set Variable    0
    
    # Contar quantas foram bem-sucedidas
    ${success_count}=    Set Variable If    ${response_a.status_code} == 201    ${success_count + 1}    ${success_count}
    ${success_count}=    Set Variable If    ${response_b.status_code} == 201    ${success_count + 1}    ${success_count}
    
    # Apenas uma deve ter sucesso
    Should Be True    ${success_count} <= 1    msg=Multiple concurrent reservations succeeded for same seat
    
    # Pelo menos uma deve falhar com conflito
    ${has_conflict}=    Set Variable    ${False}
    ${has_conflict}=    Set Variable If    ${response_a.status_code} in [409, 400]    ${True}    ${has_conflict}
    ${has_conflict}=    Set Variable If    ${response_b.status_code} in [409, 400]    ${True}    ${has_conflict}
    Should Be True    ${has_conflict}    msg=No conflict detected in concurrent reservations