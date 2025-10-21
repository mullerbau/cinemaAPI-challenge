*** Settings ***
Library    Browser
Variables  ../variables/config.robot

*** Keywords ***
Abrir Navegador
    New Browser    ${BROWSER}    headless=${HEADLESS}
    New Page    ${BASE_URL_WEB}
    Set Browser Timeout    ${TIMEOUT}

Fechar Navegador
    Close Browser

Fazer Login Web
    [Arguments]    ${email}    ${password}
    Wait For Elements State    id=email    visible
    Fill Text    id=email    ${email}
    Fill Text    id=password    ${password}
    Click    button:has-text("Entrar")
    Wait For Elements State    text=Bem-vindo    visible

Validar Login Realizado
    Wait For Elements State    button:has-text("Sair")    visible
    Get Text    body    contains    Meu Perfil

Fazer Logout
    Click    button:has-text("Sair")
    Wait For Elements State    text=Login    visible

Navegar Para Página
    [Arguments]    ${page}
    Click    text=${page}
    Wait For Elements State    text=${page}    visible

Selecionar Filme
    [Arguments]    ${movie_title}
    Wait For Elements State    h3:has-text("${movie_title}")    visible
    Click    h3:has-text("${movie_title}")
    Wait For Elements State    text=Sessões Disponíveis    visible

Selecionar Sessão
    [Arguments]    ${session_time}
    Wait For Elements State    button:has-text("${session_time}")    visible
    Click    button:has-text("${session_time}")
    Wait For Elements State    text=Seleção de Assentos    visible

Selecionar Assento
    [Arguments]    ${seat_number}
    Wait For Elements State    [data-seat="${seat_number}"]    visible
    Click    [data-seat="${seat_number}"]
    Get Attribute    [data-seat="${seat_number}"]    class    contains    selected

Confirmar Reserva
    Click    button:has-text("Confirmar Reserva")
    Wait For Elements State    text=Reserva confirmada    visible

Validar Mensagem de Erro
    [Arguments]    ${error_message}
    Wait For Elements State    text=${error_message}    visible