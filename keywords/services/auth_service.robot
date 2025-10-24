*** Settings ***
Documentation    Service Object para operações de autenticação
Library          RequestsLibrary
Library          JSONLibrary
Resource         ../../variables/config.robot

*** Keywords ***
Setup Auth Session
    [Documentation]    Configura sessão para endpoints de autenticação
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Login User
    [Documentation]    Realiza login de usuário
    [Arguments]    ${email}    ${password}
    ${login_data}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/login    json=${login_data}    expected_status=any
    RETURN    ${response}

Register User
    [Documentation]    Registra novo usuário
    [Arguments]    ${name}    ${email}    ${password}
    ${user_data}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/register    json=${user_data}    expected_status=any
    RETURN    ${response}

Get User Profile
    [Documentation]    Obtém perfil do usuário autenticado
    [Arguments]    ${token}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /auth/me    headers=${headers}    expected_status=any
    RETURN    ${response}

Get User Profile Without Token
    [Documentation]    Tenta obter perfil sem token de autenticação
    ${response}=    GET On Session    cinema_api    /auth/me    expected_status=any
    RETURN    ${response}

Extract Token From Login Response
    [Documentation]    Extrai token JWT da resposta de login
    [Arguments]    ${login_response}
    ${token}=    Get Value From Json    ${login_response.json()}    $.data.token
    RETURN    ${token[0]}