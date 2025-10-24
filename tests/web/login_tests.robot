*** Settings ***
Documentation    Testes de login da interface web
Resource         ../resources/base.robot
Test Setup       Setup Web Tests
Test Teardown    Teardown Web Tests

*** Test Cases ***
CT-WEB-001 - Login com credenciais válidas
    [Documentation]    Valida login pela interface web
    [Tags]    web    login    positive    smoke    critical
    # Implementação será adicionada
    
CT-WEB-002 - Login com credenciais inválidas
    [Documentation]    Valida erro de login com credenciais incorretas
    [Tags]    web    login    negative    validation
    # Implementação será adicionada