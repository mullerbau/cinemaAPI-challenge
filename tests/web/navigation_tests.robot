*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    New Browser    chromium    headless=false
Suite Teardown    Close Browser
Test Tags    web    navigation

*** Test Cases ***
Web-Navigation-001: Home Page Load
    [Documentation]    Testa carregamento da página inicial
    [Tags]    positive    smoke    critical
    New Page    ${BASE_URL_WEB}
    Wait For Elements State    css=.header    visible    timeout=10s
    Get Title    contains    Cinema

Web-Navigation-002: Header Navigation Links
    [Documentation]    Testa links de navegação no header
    [Tags]    positive    navigation
    New Page    ${BASE_URL_WEB}
    Click    css=.nav-movies
    Wait For Elements State    css=.movies-page    visible    timeout=5s
    Click    css=.nav-home
    Wait For Elements State    css=.home-page    visible    timeout=5s

Web-Navigation-003: Footer Links
    [Documentation]    Testa links no footer
    [Tags]    positive    navigation
    New Page    ${BASE_URL_WEB}
    Scroll To Element    css=.footer
    Click    css=.footer-about
    Wait For Elements State    css=.about-page    visible    timeout=5s

Web-Navigation-004: Breadcrumb Navigation
    [Documentation]    Testa navegação por breadcrumb
    [Tags]    positive    navigation
    New Page    ${BASE_URL_WEB}/movies
    Click    ${MOVIE_CARD} >> nth=0
    Click    css=.breadcrumb-movies
    Wait For Elements State    css=.movies-page    visible    timeout=5s

Web-Navigation-005: Back Button Functionality
    [Documentation]    Testa funcionalidade do botão voltar
    [Tags]    positive    navigation
    New Page    ${BASE_URL_WEB}
    Click    css=.nav-movies
    Go Back
    Wait For Elements State    css=.home-page    visible    timeout=5s

Web-Navigation-006: Page Not Found (404)
    [Documentation]    Testa página não encontrada
    [Tags]    negative    error
    New Page    ${BASE_URL_WEB}/nonexistent-page
    Wait For Elements State    css=.error-404    visible    timeout=5s
    Get Text    css=.error-message    contains    Page not found