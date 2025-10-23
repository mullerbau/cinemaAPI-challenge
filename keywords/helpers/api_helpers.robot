*** Settings ***
Documentation    Keywords auxiliares para testes de API
Library          RequestsLibrary
Library          JSONLibrary

*** Keywords ***
Setup API Session
    [Documentation]    Configura sessão base para API
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Create Auth Headers
    [Documentation]    Cria headers com token de autenticação
    [Arguments]    ${token}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    RETURN    ${headers}

Generate Sample Seats
    [Documentation]    Gera lista de assentos para testes
    [Arguments]    ${quantity}=2
    ${seats}=    Create List
    FOR    ${i}    IN RANGE    1    ${quantity + 1}
        Append To List    ${seats}    A${i}
    END
    RETURN    ${seats}

Generate Unique Email
    [Documentation]    Gera email único para testes
    ${timestamp}=    Get Current Date    result_format=%Y%m%d%H%M%S
    ${unique_email}=    Set Variable    test${timestamp}@cinema.com
    RETURN    ${unique_email}