*** Settings ***
Documentation    Page Object para página de login
Library          Browser
Resource         ../../variables/config.robot

*** Variables ***
${LOGIN_URL}              ${WEB_BASE_URL}/login
${EMAIL_INPUT}            css=#email
${PASSWORD_INPUT}         css=#password
${LOGIN_BUTTON}           css=button[type="submit"]
${ERROR_MESSAGE}          css=.error-message
${SUCCESS_INDICATOR}      css=.home-container h1 >> text=Welcome to Cinema App

*** Keywords ***
Open Login Page
    [Documentation]    Abre a página de login
    New Page    ${LOGIN_URL}
    Wait For Elements State    ${EMAIL_INPUT}    visible    timeout=10s

Fill Login Form
    [Arguments]    ${email}    ${password}
    Fill Text      ${EMAIL_INPUT}    ${email}
    Fill Text      ${PASSWORD_INPUT}    ${password}

Click Login Button
    Click    ${LOGIN_BUTTON}
    Wait For Load State    networkidle    timeout=5s

Verify Login Success
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=10s
    ${welcome_text}=    Get Text    //*[@id="root"]/main/div/h1
    Should Contain Any    ${welcome_text}    Welcome    Bem-vindo

Verify Login Error
    [Arguments]    ${expected_error}=Invalid credentials
    ${current_url}=    Get Url
    Should Contain    ${current_url}    /login