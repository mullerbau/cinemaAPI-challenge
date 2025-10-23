*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables  ../variables/config.robot

*** Keywords ***
Setup Reservations Service
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Create Reservation
    [Arguments]    ${token}    ${session_id}    ${seats}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${reservation_data}=    Create Dictionary    sessionId=${session_id}    seats=${seats}
    ${response}=    POST On Session    cinema_api    /reservations    json=${reservation_data}    headers=${headers}
    RETURN    ${response}

Create Reservation Without Auth
    [Arguments]    ${session_id}    ${seats}
    ${reservation_data}=    Create Dictionary    sessionId=${session_id}    seats=${seats}
    ${response}=    POST On Session    cinema_api    /reservations    json=${reservation_data}    expected_status=any
    RETURN    ${response}

Get User Reservations
    [Arguments]    ${token}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /reservations    headers=${headers}
    RETURN    ${response}

Get Reservation By ID
    [Arguments]    ${token}    ${reservation_id}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}

Cancel Reservation
    [Arguments]    ${token}    ${reservation_id}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    DELETE On Session    cinema_api    /reservations/${reservation_id}    headers=${headers}
    RETURN    ${response}

Create Sample Seats List
    ${seats}=    Create List    A1    A2
    RETURN    ${seats}