*** Settings ***
Documentation    Arquivo base com todas as importações centralizadas
...              Importar este arquivo em todos os testes para ter acesso completo

# Libraries principais
Library          RequestsLibrary
Library          JSONLibrary
Library          Collections
Library          String
Library          DateTime
Library          Process

# Service Objects
Resource         ../keywords/services/auth_service.robot
Resource         ../keywords/services/movies_service.robot
Resource         ../keywords/services/reservations_service.robot

# Helpers
Resource         ../keywords/helpers/api_helpers.robot
Resource         ../keywords/helpers/validation_helpers.robot

# Keywords específicas (comentado temporariamente)
# Resource         ../keywords/data_management.robot
# Resource         ../keywords/web_keywords.robot

# Variáveis globais
Resource         ../variables/config.robot

*** Keywords ***
Setup API Tests
    [Documentation]    Setup padrão para testes de API
    Setup API Session
    Log    API Tests setup completed

Setup Web Tests  
    [Documentation]    Setup padrão para testes Web
    Abrir Navegador

Teardown Tests
    [Documentation]    Teardown padrão para todos os testes
    Log    Test completed successfully

Teardown Web Tests
    [Documentation]    Teardown específico para testes web
    Fechar Navegador

Setup Auth Service
    [Documentation]    Setup para testes de autenticação
    Setup Auth Session

Setup Movies Service
    [Documentation]    Setup para testes de filmes
    Setup Movies Session

Setup Reservations Service
    [Documentation]    Setup para testes de reservas
    Setup Reservations Session

Cleanup Test Data
    [Documentation]    Limpa dados de teste do banco
    ${result}=    Run Process    python    libs/mongodb_cleanup.py    cwd=${CURDIR}/..
    Log    MongoDB cleanup completed: ${result.stdout}

Combine Dictionaries
    [Documentation]    Combina dois dicionários
    [Arguments]    ${dict1}    ${dict2}
    ${combined}=    Create Dictionary
    FOR    ${key}    IN    @{dict1.keys()}
        Set To Dictionary    ${combined}    ${key}=${dict1}[${key}]
    END
    FOR    ${key}    IN    @{dict2.keys()}
        Set To Dictionary    ${combined}    ${key}=${dict2}[${key}]
    END
    RETURN    ${combined}