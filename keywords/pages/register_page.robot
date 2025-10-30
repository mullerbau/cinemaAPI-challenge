*** Settings ***
Resource    ../../variables/config.robot
Library     Browser

*** Keywords ***
Open Register Page
    New Page    ${WEB_BASE_URL}/register

Fill Register Form
    [Arguments]    ${name}    ${email}    ${password}    ${confirm_password}
    Fill Text    id=name    ${name}
    Fill Text    id=email    ${email}
    Fill Text    id=password    ${password}
    Fill Text    id=confirmPassword    ${confirm_password}

Click Register Button
    Click    button[type="submit"]

Verify Register Success
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=10s
    ${welcome_text}=    Get Text    //*[@id="root"]/main/div/h1
    Should Contain Any    ${welcome_text}    Welcome    Bem-vindo

Verify Register Error
    [Arguments]    ${expected_error}
    Wait For Elements State    text=${expected_error}    visible    timeout=5s