*** Settings ***
Documentation    Testes de navegação da interface web
Resource         ../resources/base.robot
Test Setup       Setup Web Tests
Test Teardown    Teardown Web Tests

*** Test Cases ***
CT-WEB-012 - Menu de navegação funcional
    [Documentation]    Valida funcionamento do menu principal
    [Tags]    web    navigation    positive    ui    smoke
    # Implementação será adicionada
    
CT-WEB-013 - Responsividade mobile
    [Documentation]    Valida layout em dispositivos móveis
    [Tags]    web    navigation    positive    responsive    ui
    # Implementação será adicionada