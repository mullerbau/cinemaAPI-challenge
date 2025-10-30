*** Settings ***
Resource    ../../variables/config.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    navigation
Test Timeout    30s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Navigation-001: Home Page Load
    [Documentation]    Testa carregamento da página inicial
    [Tags]    positive    smoke    critical
    New Page    ${WEB_BASE_URL}
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=10s
    ${title}=    Get Title
    Should Contain    ${title}    Cinema

Web-Navigation-002: Navigate To Movies Page
    [Documentation]    Testa navegação para página de filmes
    [Tags]    positive    navigation
    New Page    ${WEB_BASE_URL}
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    New Page    ${WEB_BASE_URL}/movies
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    ${movies_title}=    Get Text    //*[@id="root"]/main/div/h1
    Should Contain Any    ${movies_title}    Movies    Filmes

Web-Navigation-003: Navigate To Login Page
    [Documentation]    Testa navegação para página de login
    [Tags]    positive    navigation
    New Page    ${WEB_BASE_URL}/login
    Wait For Elements State    css=#email    visible    timeout=5s
    Wait For Elements State    css=#password    visible    timeout=5s

Web-Navigation-004: Navigate To Register Page
    [Documentation]    Testa navegação para página de cadastro
    [Tags]    positive    navigation
    New Page    ${WEB_BASE_URL}/register
    Wait For Elements State    css=#name    visible    timeout=5s
    Wait For Elements State    css=#email    visible    timeout=5s

Web-Navigation-005: Back Button Functionality
    [Documentation]    Testa funcionalidade do botão voltar
    [Tags]    positive    navigation
    New Page    ${WEB_BASE_URL}
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    Click    text=Movies
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    Go Back
    Sleep    2s
    ${current_url}=    Get Url
    Should Not Contain    ${current_url}    /movies

Web-Navigation-006: Page Not Found (404)
    [Documentation]    Testa página não encontrada
    [Tags]    negative    error
    New Page    ${WEB_BASE_URL}/pagina-inexistente
    Sleep    2s
    ${current_url}=    Get Url
    Should Contain    ${current_url}    pagina-inexistente