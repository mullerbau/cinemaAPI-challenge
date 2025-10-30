*** Settings ***
Resource    ../../variables/config.robot
Resource    ../../keywords/pages/register_page.robot
Resource    ../../libs/database_keywords.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    register
Test Timeout    30s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Register-001: Register With Valid Data
    [Documentation]    Testa cadastro com dados válidos
    [Tags]    positive    smoke    critical
    Open Register Page
    Fill Register Form    ${TEST_USER_NAME}    teste001@cinema.com    ${TEST_USER_PASSWORD}    ${TEST_USER_PASSWORD}
    Click Register Button
    Verify Register Success

Web-Register-002: Register With Empty Fields
    [Documentation]    Testa cadastro com campos vazios
    [Tags]    negative    validation
    Open Register Page
    Fill Register Form    ${EMPTY}    ${EMPTY}    ${EMPTY}    ${EMPTY}
    Click Register Button

Web-Register-003: Register With Password Mismatch
    [Documentation]    Testa cadastro com senhas diferentes
    [Tags]    negative    validation
    Open Register Page
    Fill Register Form    ${TEST_USER_NAME}    teste002@cinema.com    ${TEST_USER_PASSWORD}    wrongpassword
    Click Register Button

Web-Register-004: Register With Invalid Email Format
    [Documentation]    Testa cadastro com email inválido
    [Tags]    negative    validation
    Open Register Page
    Fill Register Form    ${TEST_USER_NAME}    invalid-email    ${TEST_USER_PASSWORD}    ${TEST_USER_PASSWORD}
    Click Register Button

Web-Register-005: Register With Existing Email
    [Documentation]    Testa cadastro com email já existente
    [Tags]    negative    validation
    Open Register Page
    Fill Register Form    ${TEST_USER_NAME}    joao@teste.com    ${TEST_USER_PASSWORD}    ${TEST_USER_PASSWORD}
    Click Register Button