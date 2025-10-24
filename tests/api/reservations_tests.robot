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
    Should Be Equal As Integers    ${response.status_code}    201
    Should Contain    ${response.json()}    data
    ${reservation}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal    ${reservation}[session]    ${session_id}
    Should Be Equal    ${reservation}[seats]    ${seats}

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
    Should Be Equal As Integers    ${response.status_code}    404

Reservations-004: Create Reservation With Occupied Seats
    [Documentation]    Testa criação de reserva com assentos já ocupados
    [Tags]    negative    business    conflict
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    Create Reservation    ${token}    ${session_id}    ${seats}
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    409

Reservations-005: Get User Reservations Successfully
    [Documentation]    Testa listagem de reservas do usuário
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    Create Reservation    ${token}    ${session_id}    ${seats}
    ${response}=    Get User Reservations    ${token}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data
    ${reservations}=    Get From Dictionary    ${response.json()}    data
    Should Not Be Empty    ${reservations}

Reservations-006: Get Reservation By ID Successfully
    [Documentation]    Testa busca de reserva por ID
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${create_response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    ${reservation}=    Get From Dictionary    ${create_response.json()}    data
    ${reservation_id}=    Get From Dictionary    ${reservation}    _id
    ${response}=    Get Reservation By ID    ${token}    ${reservation_id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data

Reservations-007: Cancel Reservation Successfully
    [Documentation]    Testa cancelamento de reserva
    [Tags]    positive    critical
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${create_response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    ${reservation}=    Get From Dictionary    ${create_response.json()}    data
    ${reservation_id}=    Get From Dictionary    ${reservation}    _id
    ${response}=    Cancel Reservation    ${token}    ${reservation_id}
    Should Be Equal As Integers    ${response.status_code}    200

Reservations-008: Cancel Non-Existent Reservation
    [Documentation]    Testa cancelamento de reserva inexistente
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${response}=    Cancel Reservation    ${token}    invalid_reservation_id
    Should Be Equal As Integers    ${response.status_code}    404

Reservations-009: Create Reservation With Empty Seats
    [Documentation]    Testa criação de reserva sem assentos
    [Tags]    negative    validation
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${empty_seats}=    Create List
    ${response}=    Create Reservation    ${token}    ${session_id}    ${empty_seats}
    Should Be Equal As Integers    ${response.status_code}    400