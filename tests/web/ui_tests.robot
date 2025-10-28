*** Settings ***
Resource    ../../variables/config.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    ui
Test Timeout    30s

*** Variables ***
${MOVIE_CARD}      css=.movie-card
${EMAIL_INPUT}     id=email
${PASSWORD_INPUT}  id=password

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-UI-001: Responsive Design Mobile
    [Documentation]    Testa design responsivo em mobile
    [Tags]    positive    responsive    mobile
    New Page    ${BASE_URL_WEB}
    Set Viewport Size    375    667
    Wait For Elements State    css=.mobile-menu    visible    timeout=5s
    Click    css=.mobile-menu-toggle
    Wait For Elements State    css=.mobile-nav    visible    timeout=5s

Web-UI-002: Responsive Design Tablet
    [Documentation]    Testa design responsivo em tablet
    [Tags]    positive    responsive    tablet
    New Page    ${BASE_URL_WEB}
    Set Viewport Size    768    1024
    Wait For Elements State    css=.header    visible    timeout=5s
    Get Element Count    css=.movie-card    >    0

Web-UI-003: Dark Mode Toggle
    [Documentation]    Testa alternância entre modo claro e escuro
    [Tags]    positive    theme
    New Page    ${BASE_URL_WEB}
    Click    css=.theme-toggle
    Wait For Elements State    css=.dark-theme    visible    timeout=5s
    Click    css=.theme-toggle
    Wait For Elements State    css=.light-theme    visible    timeout=5s

Web-UI-004: Loading States
    [Documentation]    Testa estados de carregamento
    [Tags]    positive    loading
    New Page    ${BASE_URL_WEB}/movies
    Wait For Elements State    css=.loading-spinner    visible    timeout=2s
    Wait For Elements State    css=.loading-spinner    hidden    timeout=10s
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=5s

Web-UI-005: Form Input Validation Visual Feedback
    [Documentation]    Testa feedback visual de validação de formulários
    [Tags]    positive    validation    ui
    New Page    ${BASE_URL_WEB}/login
    Fill Text    ${EMAIL_INPUT}    invalid-email
    Click    ${PASSWORD_INPUT}
    Wait For Elements State    css=.input-error    visible    timeout=5s

Web-UI-006: Accessibility Features
    [Documentation]    Testa recursos de acessibilidade
    [Tags]    positive    accessibility
    New Page    ${BASE_URL_WEB}
    Keyboard Key    press    Tab
    Get Element    css=:focus    # Verifica se há elemento focado
    Keyboard Key    press    Enter
    # Verifica se navegação por teclado funciona

Web-UI-007: Image Loading and Alt Text
    [Documentation]    Testa carregamento de imagens e texto alternativo
    [Tags]    positive    images    accessibility
    New Page    ${BASE_URL_WEB}/movies
    Wait For Elements State    css=.movie-poster    visible    timeout=10s
    Get Attribute    css=.movie-poster >> nth=0    alt    !=    ${EMPTY}

Web-UI-008: Tooltip and Help Text
    [Documentation]    Testa tooltips e textos de ajuda
    [Tags]    positive    help
    New Page    ${BASE_URL_WEB}/movies
    Hover    css=.info-icon
    Wait For Elements State    css=.tooltip    visible    timeout=3s
    Get Text    css=.tooltip    !=    ${EMPTY}