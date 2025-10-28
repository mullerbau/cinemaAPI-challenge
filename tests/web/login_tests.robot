*** Settings ***
Resource    ../../variables/config.robot
Resource    ../../keywords/pages/login_page.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    login
Test Timeout    30s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Login-001: Login With Valid Credentials
    [Documentation]    Testa login com credenciais válidas
    [Tags]    positive    smoke    critical
    Open Login Page
    Fill Login Form    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Click Login Button
    Verify Login Success

Web-Login-002: Login With Invalid Email
    [Documentation]    Testa login com email inválido
    [Tags]    negative    validation
    Open Login Page
    Fill Login Form    invalid@email.com    ${TEST_USER_PASSWORD}
    Click Login Button
    Verify Login Error    Invalid credentials

Web-Login-003: Login With Invalid Password
    [Documentation]    Testa login com senha inválida
    [Tags]    negative    validation
    Open Login Page
    Fill Login Form    ${TEST_USER_EMAIL}    wrongpassword
    Click Login Button
    Verify Login Error    Invalid credentials

Web-Login-004: Login With Empty Fields
    [Documentation]    Testa login com campos vazios
    [Tags]    negative    validation
    Open Login Page
    Fill Login Form    ${EMPTY}    ${EMPTY}
    Click Login Button
    Verify Login Error    Required fields

Web-Login-005: Login Form Validation
    [Documentation]    Testa validação de formato de email
    [Tags]    negative    validation
    Open Login Page
    Fill Login Form    invalid-email    ${TEST_USER_PASSWORD}
    Click Login Button
    Verify Login Error    Invalid email format
