*** Settings ***
Documentation    Testes de reservas da interface web
Resource         ../resources/base.robot
Test Setup       Setup Web Tests
Test Teardown    Teardown Web Tests

*** Test Cases ***
CT-WEB-018 - Fluxo completo de reserva
    [Documentation]    Valida jornada completa de reserva via web
    [Tags]    web    reservations    positive    critical    business_critical    e2e
    # Implementação será adicionada
    
CT-WEB-019 - Tentar reservar sem login
    [Documentation]    Valida redirecionamento para login ao tentar reservar
    [Tags]    web    reservations    negative    security    auth_required
    # Implementação será adicionada
    
CT-WEB-020 - Cancelar reserva via interface
    [Documentation]    Valida cancelamento de reserva pela web
    [Tags]    web    reservations    positive    crud    user_action
    # Implementação será adicionada