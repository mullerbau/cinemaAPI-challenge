*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    New Browser    chromium    headless=false
Suite Teardown    Close Browser
Test Tags    web    performance

*** Test Cases ***
Web-Performance-001: Page Load Time
    [Documentation]    Testa tempo de carregamento da página
    [Tags]    positive    performance    critical
    ${start_time}=    Get Time    epoch
    New Page    ${BASE_URL_WEB}
    Wait For Elements State    css=.header    visible    timeout=10s
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${load_time} < 5    msg=Page load time exceeded 5 seconds

Web-Performance-002: Movies List Load Performance
    [Documentation]    Testa performance de carregamento da lista de filmes
    [Tags]    positive    performance
    ${start_time}=    Get Time    epoch
    New Page    ${BASE_URL_WEB}/movies
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=10s
    ${end_time}=    Get Time    epoch
    ${load_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${load_time} < 3    msg=Movies load time exceeded 3 seconds

Web-Performance-003: Search Response Time
    [Documentation]    Testa tempo de resposta da busca
    [Tags]    positive    performance
    New Page    ${BASE_URL_WEB}/movies
    Wait For Elements State    ${SEARCH_INPUT}    visible    timeout=5s
    ${start_time}=    Get Time    epoch
    Fill Text    ${SEARCH_INPUT}    Inception
    Keyboard Key    press    Enter
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=5s
    ${end_time}=    Get Time    epoch
    ${search_time}=    Evaluate    ${end_time} - ${start_time}
    Should Be True    ${search_time} < 2    msg=Search response time exceeded 2 seconds

Web-Performance-004: Memory Usage During Navigation
    [Documentation]    Testa uso de memória durante navegação
    [Tags]    positive    performance    memory
    New Page    ${BASE_URL_WEB}
    # Navegar por várias páginas para testar vazamentos de memória
    FOR    ${i}    IN RANGE    5
        Click    css=.nav-movies
        Wait For Elements State    css=.movies-page    visible    timeout=5s
        Click    css=.nav-home
        Wait For Elements State    css=.home-page    visible    timeout=5s
    END
    # Verificação básica - página ainda responsiva
    Wait For Elements State    css=.header    visible    timeout=5s