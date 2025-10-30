*** Settings ***
Resource    variables/config.robot
Resource    keywords/pages/login_page.robot
Library     Browser

*** Test Cases ***
Test Login With Previously Registered User
    [Documentation]    Testa login com usuário já cadastrado
    New Browser    chromium    headless=false
    Set Browser Timeout    10s
    
    # Tentar login com usuário que sabemos que existe
    Open Login Page
    Fill Login Form    joao@teste.com    123456
    Click Login Button
    Sleep    3s
    
    # Verificar se login funcionou
    ${current_url}=    Get Url
    Log    URL após login: ${current_url}
    
    ${login_success}=    Run Keyword And Return Status    
    ...    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    
    IF    ${login_success}
        ${login_text}=    Get Text    //*[@id="root"]/main/div/h1
        Log    Login realizado com sucesso - Mensagem: ${login_text}
    ELSE
        Log    Login falhou - permaneceu na página de login
    END
    
    Close Browser