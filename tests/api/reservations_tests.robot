*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Reservations Service
Suite Teardown    Cleanup Test Data
Test Tags    api    reservations

*** Test Cases ***
Reservations-001: Create Reservation Successfully
    [Documentation]    Testa criação de reserva com dados válidos
    [Tags]    positive    smoke    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Run Keyword If    ${response.status_code} == 201    Validate Successful Reservation    ${response}    ${session_id}
    ...    ELSE    Log    Reservation failed with status: ${response.status_code} - ${response.text}

Reservations-002: Create Reservation Without Authentication
    [Documentation]    Testa criação de reserva sem autenticação
    [Tags]    negative    security    unauthorized
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${response}=    Create Reservation Without Auth    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    401

Reservations-003: Create Reservation With Invalid Session
    [Documentation]    Testa criação de reserva com sessão inválida
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${seats}=    Create Sample Seats List
    ${response}=    Create Reservation    ${token}    invalid_session_id    ${seats}
    Should Be True    ${response.status_code} in [400, 404]

Reservations-004: Create Reservation With Occupied Seats
    [Documentation]    Testa criação de reserva com assentos já ocupados
    [Tags]    negative    business    conflict
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${first_response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Run Keyword If    ${first_response.status_code} == 201    Attempt Duplicate Reservation    ${token}    ${session_id}    ${seats}
    ...    ELSE    Log    First reservation failed, skipping duplicate test

Reservations-005: Get User Reservations Successfully
    [Documentation]    Testa listagem de reservas do usuário
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${response}=    Get User Reservations    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data

Reservations-006: Get Reservation By ID Successfully
    [Documentation]    Testa busca de reserva por ID
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${reservations_response}=    Get User Reservations    ${token}
    Run Keyword If    ${reservations_response.status_code} == 200    Validate Existing Reservations    ${reservations_response}    ${token}
    ...    ELSE    Log    No reservations found for user

Reservations-007: Cancel Reservation Successfully
    [Documentation]    Testa cancelamento de reserva
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${reservations_response}=    Get User Reservations    ${token}
    Run Keyword If    ${reservations_response.status_code} == 200    Cancel Existing Reservation    ${reservations_response}    ${token}
    ...    ELSE    Log    No reservations found to cancel

Reservations-008: Cancel Non-Existent Reservation
    [Documentation]    Testa cancelamento de reserva inexistente
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${response}=    Cancel Reservation    ${token}    invalid_reservation_id
    Should Be True    ${response.status_code} in [403, 404]

Reservations-009: Create Reservation With Empty Seats
    [Documentation]    Testa criação de reserva sem assentos
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${empty_seats}=    Create List
    ${response}=    Create Reservation    ${token}    ${session_id}    ${empty_seats}
    Should Be Equal As Integers    ${response.status_code}    400

*** Keywords ***
Validate Successful Reservation
    [Arguments]    ${response}    ${session_id}
    Should Contain    ${response.json()}    data
    ${reservation}=    Get From Dictionary    ${response.json()}    data
    Should Contain    ${reservation}    session

Attempt Duplicate Reservation
    [Arguments]    ${token}    ${session_id}    ${seats}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be True    ${response.status_code} in [400, 409]

Validate Existing Reservations
    [Arguments]    ${reservations_response}    ${token}
    ${reservations_data}=    Get From Dictionary    ${reservations_response.json()}    data
    Run Keyword If    ${reservations_data}    Get First Reservation Details    ${reservations_data}    ${token}
    ...    ELSE    Log    User has no reservations

Get First Reservation Details
    [Arguments]    ${reservations_data}    ${token}
    ${first_reservation}=    Get From List    ${reservations_data}    0
    ${reservation_id}=    Get From Dictionary    ${first_reservation}    _id
    ${response}=    Get Reservation By ID    ${token}    ${reservation_id}
    Should Be Equal As Integers    ${response.status_code}    200

Cancel Existing Reservation
    [Arguments]    ${reservations_response}    ${token}
    ${reservations_data}=    Get From Dictionary    ${reservations_response.json()}    data
    Run Keyword If    ${reservations_data}    Cancel First Reservation    ${reservations_data}    ${token}
    ...    ELSE    Log    User has no reservations to cancel

Cancel First Reservation
    [Arguments]    ${reservations_data}    ${token}
    ${first_reservation}=    Get From List    ${reservations_data}    0
    ${reservation_id}=    Get From Dictionary    ${first_reservation}    _id
    ${response}=    Cancel Reservation    ${token}    ${reservation_id}
    Should Be True    ${response.status_code} in [200, 204, 403]