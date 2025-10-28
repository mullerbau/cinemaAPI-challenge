*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables  ../variables/config.robot

*** Keywords ***
Setup API Session
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Fazer Login Via API
    [Arguments]    ${email}    ${password}
    ${login_data}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/login    json=${login_data}
    Should Be Equal As Strings    ${response.status_code}    200
    ${token}=    Get Value From Json    ${response.json()}    $.data.token
    Set Global Variable    ${AUTH_TOKEN}    ${token[0]}
    RETURN    ${response}

Fazer Requisição Autenticada
    [Arguments]    ${method}    ${endpoint}    ${data}=${None}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${AUTH_TOKEN}
    ${headers}=    Create Dictionary    &{API_HEADERS}    &{auth_headers}
    IF    '${method}' == 'GET'
        ${response}=    GET On Session    cinema_api    ${endpoint}    headers=${headers}
    ELSE IF    '${method}' == 'POST'
        ${response}=    POST On Session    cinema_api    ${endpoint}    json=${data}    headers=${headers}
    ELSE IF    '${method}' == 'PUT'
        ${response}=    PUT On Session    cinema_api    ${endpoint}    json=${data}    headers=${headers}
    ELSE IF    '${method}' == 'DELETE'
        ${response}=    DELETE On Session    cinema_api    ${endpoint}    headers=${headers}
    END
    RETURN    ${response}

Validar Resposta de Sucesso
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Not Be Empty    ${response.json()}

Validar Resposta de Erro
    [Arguments]    ${response}    ${expected_status}    ${expected_message}=${None}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    IF    '${expected_message}' != '${None}'
        ${error_message}=    Get Value From Json    ${response.json()}    $.message
        Should Contain    ${error_message[0]}    ${expected_message}
    END

Fazer Login Admin
    [Documentation]    Faz login como administrador
    ${response}=    Fazer Login Via API    ${ADMIN_EMAIL}    ${ADMIN_PASSWORD}
    RETURN    ${response}

Fazer Login Usuario Teste
    [Documentation]    Faz login como usuário de teste
    ${response}=    Fazer Login Via API    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    RETURN    ${response}