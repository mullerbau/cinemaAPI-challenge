*** Settings ***
Documentation    Page Object para página de login
Library          Browser

*** Variables ***
${LOGIN_URL}              ${BASE_URL_WEB}/login
${EMAIL_INPUT}            id=email
${PASSWORD_INPUT}         id=password
${LOGIN_BUTTON}           css=button[type="submit"]
${ERROR_MESSAGE}          css=.error-message

*** Keywords ***
Open Login Page
    [Documentation]    Abre a página de login
    New Page    ${LOGIN_URL}
    Wait For Elements State    ${EMAIL_INPUT}    visible    timeout=10s

Fill Login Form
    [Arguments]    ${email}    ${password}
    Fill Text    ${EMAIL_INPUT}    ${email}
    Fill Text    ${PASSWORD_INPUT}    ${password}

Click Login Button
    Click    ${LOGIN_BUTTON}

Verify Login Success
    Wait For Elements State    css=.user-menu    visible    timeout=10s

Verify Login Error
    [Arguments]    ${expected_message}
    Wait For Elements State    ${ERROR_MESSAGE}    visible    timeout=5s
    Get Text    ${ERROR_MESSAGE}    contains    ${expected_message}