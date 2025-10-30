*** Settings ***
Resource    ../../variables/config.robot
Library     Browser
Library     DateTime
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    performance
Test Timeout    60s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    15s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Performance-001: Home Page Load Time
    [Documentation]    Testa tempo de carregamento da página inicial
    [Tags]    positive    performance    critical
    ${start_time}=    Get Time    epoch
    New Page    ${WEB_BASE_URL}
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=10s
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${load_time} < 10    msg=Home page load time exceeded 10 seconds
    Log    Home page loaded in ${load_time} seconds

Web-Performance-002: Movies Page Load Performance
    [Documentation]    Testa performance de carregamento da lista de filmes
    [Tags]    positive    performance
    ${start_time}=    Get Time    epoch
    New Page    ${WEB_BASE_URL}/movies
    Wait For Elements State    css=.movie-card >> nth=0    visible    timeout=10s
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${load_time} < 10    msg=Movies load time exceeded 10 seconds
    Log    Movies page loaded in ${load_time} seconds

Web-Performance-003: Search Response Time
    [Documentation]    Testa tempo de resposta da busca
    [Tags]    positive    performance
    New Page    ${WEB_BASE_URL}/movies
    Wait For Elements State    css=input[placeholder="Buscar filmes..."]    visible    timeout=5s
    ${start_time}=    Get Time    epoch
    Fill Text    css=input[placeholder="Buscar filmes..."]    Inception
    Sleep    2s
    ${end_time}=    Get Time    epoch
    ${search_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${search_time} < 5    msg=Search response time exceeded 5 seconds
    Log    Search completed in ${search_time} seconds

Web-Performance-004: Multiple Page Navigation
    [Documentation]    Testa performance durante navegação entre páginas
    [Tags]    positive    performance
    ${start_time}=    Get Time    epoch
    New Page    ${WEB_BASE_URL}
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    New Page    ${WEB_BASE_URL}/movies
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=5s
    New Page    ${WEB_BASE_URL}/login
    Wait For Elements State    css=#email    visible    timeout=5s
    ${end_time}=    Get Time    epoch
    ${total_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${total_time} < 15    msg=Navigation time exceeded 15 seconds
    Log    Multiple navigation completed in ${total_time} seconds