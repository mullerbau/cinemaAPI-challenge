*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Reservations Service
Suite Teardown    Cleanup Test Data
Test Tags    api    edge_cases

*** Test Cases ***
Edge-001: Maximum Seats Per Reservation
    [Documentation]    Testa limite máximo de assentos por reserva
    [Tags]    negative    boundary    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${max_seats}=    Create Large Seats List    50
    ${response}=    Create Reservation    ${token}    ${session_id}    ${max_seats}
    Should Be True    ${response.status_code} in [400, 413]

Edge-002: Empty Seat Row
    [Documentation]    Testa assento com fila vazia
    [Tags]    negative    boundary    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${invalid_seat}=    Create Dictionary    row=${EMPTY}    number=1    type=full
    ${seats}=    Create List    ${invalid_seat}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    400

Edge-003: Negative Seat Number
    [Documentation]    Testa número de assento negativo
    [Tags]    negative    boundary    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${invalid_seat}=    Create Dictionary    row=A    number=-1    type=full
    ${seats}=    Create List    ${invalid_seat}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    400

Edge-004: Zero Seat Number
    [Documentation]    Testa número de assento zero
    [Tags]    negative    boundary    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${invalid_seat}=    Create Dictionary    row=A    number=0    type=full
    ${seats}=    Create List    ${invalid_seat}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    400

Edge-005: Invalid Ticket Type
    [Documentation]    Testa tipo de ingresso inválido
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${invalid_seat}=    Create Dictionary    row=A    number=1    type=invalid
    ${seats}=    Create List    ${invalid_seat}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    400

Edge-006: Extremely Long Session ID
    [Documentation]    Testa ID de sessão extremamente longo
    [Tags]    negative    boundary    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${seats}=    Create Sample Seats List
    ${long_session_id}=    Evaluate    'a' * 1000
    ${response}=    Create Reservation    ${token}    ${long_session_id}    ${seats}
    Should Be True    ${response.status_code} in [400, 404, 414]

*** Keywords ***
Create Large Seats List
    [Arguments]    ${quantity}
    ${seats}=    Create List
    ${quantity_plus_one}=    Evaluate    ${quantity} + 1
    FOR    ${i}    IN RANGE    1    ${quantity_plus_one}
        ${row}=    Set Variable If    ${i} <= 26    A    Z
        ${seat}=    Create Dictionary    row=${row}    number=${i}    type=full
        Append To List    ${seats}    ${seat}
    END
    RETURN    ${seats}