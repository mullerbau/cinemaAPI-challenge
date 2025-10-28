*** Settings ***
Documentation    Page Object para página de login
Library          Browser
Resource         ../../variables/config.robot

*** Variables ***
${LOGIN_URL}              ${BASE_URL_WEB}/login
${EMAIL_INPUT}            id=email
${PASSWORD_INPUT}         id=password
${LOGIN_BUTTON}           css=button[type="submit"]
${ERROR_MESSAGE}          css=.error-message
${SUCCESS_INDICATOR}      css=.user-menu, css=.dashboard, css=h1:has-text("Movies")

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
    Wait For Load State    networkidle    timeout=5s

Verify Login Success
    Wait For Elements State    ${SUCCESS_INDICATOR}    visible    timeout=10s

Verify Login Error
    [Arguments]    ${expected_message}=${EMPTY}
    Wait For Elements State    ${ERROR_MESSAGE}    visible    timeout=5s
    IF    '${expected_message}' != '${EMPTY}'
        ${error_text}=    Get Text    ${ERROR_MESSAGE}
        Should Contain    ${error_text}    ${expected_message}    ignore_case=True
    END