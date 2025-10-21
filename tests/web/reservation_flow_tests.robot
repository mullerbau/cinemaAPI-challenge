*** Settings ***
Documentation    Testes de fluxo completo de reserva
Resource         ../resources/common.robot
Test Setup       Setup Web Test
Test Teardown    Teardown Web Test

*** Test Cases ***
CT017 - Fluxo completo de reserva
    [Documentation]    Valida fluxo end-to-end de reserva
    [Tags]    web    reservation    flow    positive
    # Login
    Go To    ${BASE_URL_WEB}/login
    Fazer Login Web    ${VALID_EMAIL}    ${VALID_PASSWORD}
    
    # Navegar para filmes
    Go To    ${BASE_URL_WEB}/movies
    Wait Until Page Contains    Filmes em Cartaz
    
    # Selecionar primeiro filme disponível
    ${first_movie}=    Get Text    xpath://div[@class='movie-card'][1]//h3
    Click Element    xpath://div[@class='movie-card'][1]
    
    # Verificar se chegou na página de detalhes
    Wait Until Page Contains    Sessões Disponíveis
    
    # Selecionar primeira sessão disponível
    Click Button    xpath://button[contains(@class, 'session-btn')][1]
    
    # Selecionar assentos
    Wait Until Page Contains    Seleção de Assentos
    Selecionar Assento    A1
    Selecionar Assento    A2
    
    # Confirmar reserva
    Confirmar Reserva
    
    # Validar sucesso
    Page Should Contain    Reserva confirmada com sucesso

CT018 - Tentativa de reserva sem login
    [Documentation]    Valida redirecionamento para login ao tentar reservar sem autenticação
    [Tags]    web    reservation    negative
    Go To    ${BASE_URL_WEB}/movies
    
    # Tentar acessar filme
    Click Element    xpath://div[@class='movie-card'][1]
    
    # Deve ser redirecionado para login
    Wait Until Page Contains    Faça login para continuar
    Location Should Contain    /login

CT019 - Validar assentos ocupados
    [Documentation]    Valida que assentos ocupados não podem ser selecionados
    [Tags]    web    reservation    negative
    Go To    ${BASE_URL_WEB}/login
    Fazer Login Web    ${VALID_EMAIL}    ${VALID_PASSWORD}
    
    Go To    ${BASE_URL_WEB}/movies
    Click Element    xpath://div[@class='movie-card'][1]
    Click Button    xpath://button[contains(@class, 'session-btn')][1]
    
    Wait Until Page Contains    Seleção de Assentos
    
    # Verificar se existem assentos ocupados
    ${occupied_seats}=    Get Element Count    xpath://button[contains(@class, 'occupied')]
    IF    ${occupied_seats} > 0
        # Tentar clicar em assento ocupado
        Click Button    xpath://button[contains(@class, 'occupied')][1]
        # Validar que não foi selecionado
        Element Should Not Have Class    xpath://button[contains(@class, 'occupied')][1]    selected
    END

CT020 - Cancelar reserva
    [Documentation]    Valida cancelamento de reserva existente
    [Tags]    web    reservation    positive
    Go To    ${BASE_URL_WEB}/login
    Fazer Login Web    ${VALID_EMAIL}    ${VALID_PASSWORD}
    
    # Ir para minhas reservas
    Navegar Para Página    Minhas Reservas
    
    # Verificar se há reservas
    ${reservations_count}=    Get Element Count    xpath://div[@class='reservation-card']
    IF    ${reservations_count} > 0
        # Cancelar primeira reserva
        Click Button    xpath://div[@class='reservation-card'][1]//button[contains(text(), 'Cancelar')]
        
        # Confirmar cancelamento
        Click Button    xpath://button[contains(text(), 'Confirmar Cancelamento')]
        
        # Validar sucesso
        Page Should Contain    Reserva cancelada com sucesso
    END