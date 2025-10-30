*** Settings ***
Resource    variables/config.robot
Resource    keywords/pages/register_page.robot
Library     Browser

*** Test Cases ***
Debug Register Form
    [Documentation]    Testa se conseguimos acessar a página de cadastro
    New Browser    chromium    headless=false
    Set Browser Timeout    10s
    Open Register Page
    Sleep    2s
    Fill Register Form    João Silva    joao@teste.com    123456    123456
    Sleep    1s
    Click Register Button
    Sleep    5s
    Close Browser