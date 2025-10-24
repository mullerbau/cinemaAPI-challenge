*** Settings ***
Documentation    Testes de filmes da interface web
Resource         ../resources/base.robot
Test Setup       Setup Web Tests
Test Teardown    Teardown Web Tests

*** Test Cases ***
CT-WEB-007 - Carregamento da página inicial
    [Documentation]    Valida carregamento da home page
    [Tags]    web    movies    positive    smoke    ui
    # Implementação será adicionada
    
CT-WEB-008 - Visualizar detalhes do filme
    [Documentation]    Valida navegação para detalhes do filme
    [Tags]    web    movies    positive    navigation
    # Implementação será adicionada