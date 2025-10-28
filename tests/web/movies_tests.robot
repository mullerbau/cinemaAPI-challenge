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
    Verify Movies Page Loaded
    Verify Movies List Loaded

Web-Movies-002: Search Movie By Title
    [Documentation]    Testa busca de filme por título
    [Tags]    positive    search
    Open Movies Page
    Verify Movies Page Loaded
    Search Movie    Inception
    Sleep    2s
    Verify Movies List Loaded

Web-Movies-003: Filter Movies By Genre
    [Documentation]    Testa filtro de filmes por gênero
    [Tags]    positive    filter
    Open Movies Page
    Verify Movies Page Loaded
    Click    css=.genre-filter
    Sleep    2s

Web-Movies-004: Search Non-Existent Movie
    [Documentation]    Testa busca por filme inexistente
    [Tags]    negative    search
    Open Movies Page
    Verify Movies Page Loaded
    Search Movie    FilmeInexistente123
    Sleep    2s
    ${has_results}=    Run Keyword And Return Status    Wait For Elements State    css=.movie-card    visible    timeout=3s
    Should Be Equal    ${has_results}    ${False}

Web-Movies-005: Click Movie Card
    [Documentation]    Testa clique em card de filme
    [Tags]    positive    navigation
    Open Movies Page
    Verify Movies Page Loaded
    Click First Movie
    Sleep    2s

Web-Movies-006: Clear Search Filter
    [Documentation]    Testa limpeza de filtro de busca
    [Tags]    positive    search
    Open Movies Page
    Verify Movies Page Loaded
    Search Movie    Test
    Sleep    1s
    Search Movie    ${EMPTY}
    Sleep    1s
    Verify Movies List Loaded

Web-Movies-007: View Movie Details
    [Documentation]    Testa visualização de detalhes do filme
    [Tags]    positive    navigation    details
    Open Movies Page
    Verify Movies Page Loaded
    Click Movie Details Button
    Verify Movie Details Page