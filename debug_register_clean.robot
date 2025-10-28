*** Settings ***
Resource    variables/config.robot
Resource    keywords/pages/register_page.robot
Resource    keywords/pages/login_page.robot
Resource    libs/database_keywords.robot
Library     Browser

*** Test Cases ***
Debug Register With Clean Database
    [Documentation]    Testa cadastro com limpeza do banco
    # Limpar banco primeiro
    Cleanup Database
    
    New Browser    chromium    headless=false
    Set Browser Timeout    10s
    
    # Cadastro
    Open Register Page
    Fill Register Form    João Silva    joao@teste.com    123456    123456
    Click Register Button
    Sleep    3s
    
    # Verificar mensagem de boas vindas
    ${welcome_visible}=    Run Keyword And Return Status    
    ...    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    
    IF    ${welcome_visible}
        ${welcome_text}=    Get Text    //*[@id="root"]/main/div/h1
        Log    Cadastro OK - Mensagem: ${welcome_text}
        
        # Agora testar login
        Open Login Page
        Fill Login Form    joao@teste.com    123456
        Click Login Button
        Sleep    3s
        
        ${login_success}=    Run Keyword And Return Status    
        ...    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
        
        IF    ${login_success}
            ${login_text}=    Get Text    //*[@id="root"]/main/div/h1
            Log    Login OK - Mensagem: ${login_text}
        ELSE
            ${current_url}=    Get Url
            Log    Login falhou - URL: ${current_url}
        END
    ELSE
        Log    Cadastro falhou - sem mensagem de boas vindas
    END
    
    Close Browser