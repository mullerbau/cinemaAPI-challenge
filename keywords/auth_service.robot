*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Resource   data_management.robot
Variables  ../variables/config.robot

*** Keywords ***
Setup Auth Service
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Login User
    [Arguments]    ${email}    ${password}
    ${login_data}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/login    json=${login_data}
    RETURN    ${response}

Register User
    [Arguments]    ${name}    ${email}    ${password}
    ${user_data}=    Create Dictionary    name=${name}    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/register    json=${user_data}
    RETURN    ${response}

Get User Profile
    [Arguments]    ${token}
    ${auth_headers}=    Create Dictionary    Authorization=Bearer ${token}
    ${headers}=    Combine Dictionaries    ${API_HEADERS}    ${auth_headers}
    ${response}=    GET On Session    cinema_api    /auth/me    headers=${headers}
    RETURN    ${response}

Extract Token From Response
    [Arguments]    ${response}
    ${token}=    Get Value From Json    ${response.json()}    $.data.token
    RETURN    ${token[0]}

Validate Success Response
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be True    ${success[0]}

Validate Error Response
    [Arguments]    ${response}    ${expected_status}    ${expected_message}=${None}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be Equal    ${success[0]}    ${False}
    IF    '${expected_message}' != '${None}'
        ${error_message}=    Get Value From Json    ${response.json()}    $.message
        Should Contain    ${error_message[0]}    ${expected_message}
    END