*** Settings ***
Resource    variables/config.robot
Resource    keywords/pages/register_page.robot
Resource    keywords/pages/login_page.robot
Library     Browser

*** Test Cases ***
Debug Register Then Login
    [Documentation]    Testa cadastro seguido de login
    New Browser    chromium    headless=false
    Set Browser Timeout    10s
    
    # Cadastro
    Open Register Page
    Fill Register Form    João Silva    joao@teste.com    123456    123456
    Click Register Button
    Sleep    3s
    
    # Verificar se apareceu mensagem de boas vindas
    ${welcome_visible}=    Run Keyword And Return Status    
    ...    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    
    IF    ${welcome_visible}
        Log    Cadastro realizado com sucesso - mensagem de boas vindas apareceu
        ${welcome_text}=    Get Text    //*[@id="root"]/main/div/h1
        Log    Texto da mensagem: ${welcome_text}
    ELSE
        Log    Cadastro pode ter falhado - mensagem de boas vindas não apareceu
    END
    
    # Tentar fazer login
    Open Login Page
    Fill Login Form    joao@teste.com    123456
    Click Login Button
    Sleep    3s
    
    # Verificar se login funcionou
    ${login_success}=    Run Keyword And Return Status    
    ...    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    
    IF    ${login_success}
        Log    Login realizado com sucesso
        ${login_text}=    Get Text    //*[@id="root"]/main/div/h1
        Log    Texto após login: ${login_text}
    ELSE
        Log    Login falhou
        ${current_url}=    Get Url
        Log    URL atual: ${current_url}
    END
    
    Sleep    2s
    Close Browser