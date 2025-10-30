*** Settings ***
Documentation    Service Object para operações de reservas
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Setup Reservations Session
    [Documentation]    Configura sessão para endpoints de reservas
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Create Reservation
    [Documentation]    Cria nova reserva com autenticação
    [Arguments]    ${token}    ${session_id}    ${seats}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${reservation_data}=    Create Dictionary    session=${session_id}    seats=${seats}
    ${response}=    POST On Session    cinema_api    /reservations    json=${reservation_data}    headers=${headers}    expected_status=any
    RETURN    ${response}

Create Reservation Without Auth
    [Documentation]    Tenta criar reserva sem autenticação
    [Arguments]    ${session_id}    ${seats}
    ${reservation_data}=    Create Dictionary    session=${session_id}    seats=${seats}
    ${response}=    POST On Session    cinema_api    /reservations    json=${reservation_data}    expected_status=any
    RETURN    ${response}

Get User Reservations
    [Documentation]    Lista reservas do usuário autenticado
    [Arguments]    ${token}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /reservations/me    headers=${headers}    expected_status=any
    RETURN    ${response}

Cancel Reservation
    [Documentation]    Cancela reserva específica
    [Arguments]    ${token}    ${reservation_id}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    DELETE On Session    cinema_api    /reservations/${reservation_id}    headers=${headers}    expected_status=any
    RETURN    ${response}

Get Reservation By ID
    [Documentation]    Busca reserva específica por ID
    [Arguments]    ${token}    ${reservation_id}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /reservations/${reservation_id}    headers=${headers}    expected_status=any
    RETURN    ${response}

Create Sample Seats List
    [Documentation]    Cria lista de assentos para testes conforme API
    ${seat1}=    Create Dictionary    row=A    number=1    type=full
    ${seat2}=    Create Dictionary    row=A    number=2    type=full
    ${seats}=    Create List    ${seat1}    ${seat2}
    RETURN    ${seats}