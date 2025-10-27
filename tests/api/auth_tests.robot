*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Auth Service
Suite Teardown    Cleanup Test Data
Test Tags    api    auth

*** Test Cases ***
Auth-001: Register New User Successfully
    [Documentation]    Testa registro de novo usuário com dados válidos
    [Tags]    positive    smoke    critical
    ${unique_email}=    Generate Unique Email
    ${response}=    Register User    Test User    ${unique_email}    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    201
    Should Contain    ${response.json()}    data
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Contain    ${data}    token
    Should Contain    ${data}    email
    Should Be Equal    ${data}[email]    ${unique_email}

Auth-002: Login With Valid Credentials
    [Documentation]    Testa login com credenciais válidas
    [Tags]    positive    smoke    critical
    Cleanup Test Data
    Register User    Test User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${response}=    Login User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data
    ${data}=    Get From Dictionary    ${response.json()}    data
    Should Contain    ${data}    token
    Should Contain    ${data}    email

Auth-003: Register User With Existing Email
    [Documentation]    Testa registro com email já existente
    [Tags]    negative    validation
    Cleanup Test Data
    Register User    Test User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${response}=    Register User    Test User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()}[message]    already exists

Auth-004: Login With Invalid Email
    [Documentation]    Testa login com email inválido
    [Tags]    negative    validation
    ${response}=    Login User    invalid@email.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain    ${response.json()}[message]    Invalid email or password

Auth-005: Login With Invalid Password
    [Documentation]    Testa login com senha incorreta
    [Tags]    negative    validation
    Cleanup Test Data
    Register User    Test User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${response}=    Login User    ${TEST_USER_EMAIL}    wrongpassword
    Should Be Equal As Integers    ${response.status_code}    401
    Should Contain    ${response.json()}[message]    Invalid email or password

Auth-006: Register With Invalid Email Format
    [Documentation]    Testa registro com formato de email inválido
    [Tags]    negative    validation
    ${response}=    Register User    Test User    invalid-email    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response.status_code}    400
    Should Contain    ${response.json()}[message]    Validation failed

Auth-007: Register With Weak Password
    [Documentation]    Testa registro com senha fraca
    [Tags]    negative    security
    ${response}=    Register User    Test User    ${TEST_USER_EMAIL}    123
    Should Be Equal As Integers    ${response.status_code}    400