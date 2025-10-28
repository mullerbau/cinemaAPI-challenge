*** Settings ***
Resource    ../../variables/config.robot
Resource    ../../keywords/pages/movies_page.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    movies
Test Timeout    30s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Movies-001: Load Movies Page Successfully
    [Documentation]    Testa carregamento da página de filmes
    [Tags]    positive    smoke    critical
    Open Movies Page
    Verify Movies List Loaded

Web-Movies-002: View Movie Details
    [Documentation]    Testa visualização de detalhes do filme
    [Tags]    positive    navigation
    Open Movies Page
    Click First Movie
    Wait For Elements State    css=.movie-details    visible    timeout=10s

Web-Movies-003: Search Movie By Title
    [Documentation]    Testa busca de filme por título
    [Tags]    positive    search
    Open Movies Page
    Search Movie    Inception
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=5s

Web-Movies-004: Filter Movies By Genre
    [Documentation]    Testa filtro de filmes por gênero
    [Tags]    positive    filter
    Open Movies Page
    Filter By Genre    Action
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=5s

Web-Movies-005: Search Non-Existent Movie
    [Documentation]    Testa busca por filme inexistente
    [Tags]    negative    search
    Open Movies Page
    Search Movie    NonExistentMovie123
    Wait For Elements State    css=.no-results    visible    timeout=5s

Web-Movies-006: Movie Card Information Display
    [Documentation]    Testa exibição de informações no card do filme
    [Tags]    positive    ui
    Open Movies Page
    Get Text    ${MOVIE_TITLE} >> nth=0    !=    ${EMPTY}
    Get Element    css=.movie-poster >> nth=0

Web-Movies-007: Movies Page Responsiveness
    [Documentation]    Testa responsividade da página de filmes
    [Tags]    positive    responsive
    Open Movies Page
    Set Viewport Size    375    667    # Mobile
    Verify Movies List Loaded
    Set Viewport Size    1920    1080   # Desktop