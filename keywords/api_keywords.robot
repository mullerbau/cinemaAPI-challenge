*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   data_management.robot
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
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
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
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be True    ${success[0]}

Validar Resposta de Erro
    [Arguments]    ${response}    ${expected_status}    ${expected_message}=${None}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be Equal    ${success[0]}    ${False}
    IF    '${expected_message}' != '${None}'
        ${error_message}=    Get Value From Json    ${response.json()}    $.message
        Should Contain    ${error_message[0]}    ${expected_message}
    END

Registrar Usuário Via API
    [Arguments]    ${name}    ${email}    ${password}
    ${user_data}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/register    json=${user_data}
    RETURN    ${response}

Obter Perfil Via API
    ${response}=    Fazer Requisição Autenticada    GET    /auth/me
    RETURN    ${response}

Atualizar Perfil Via API
    [Arguments]    ${data}
    ${response}=    Fazer Requisição Autenticada    PUT    /auth/profile    ${data}
    RETURN    ${response}

Listar Filmes Via API
    ${response}=    GET On Session    cinema_api    /movies
    RETURN    ${response}

Obter Filme Por ID Via API
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}
    RETURN    ${response}