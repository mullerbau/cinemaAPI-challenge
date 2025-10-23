*** Settings ***
Documentation    Arquivo base com todas as importações centralizadas
...              Importar este arquivo em todos os testes para ter acesso completo

# Libraries principais
Library          RequestsLibrary
Library          JSONLibrary
Library          Browser
Library          Collections
Library          String
Library          DateTime

# Data Management
Library          ../utils/data_manager.py

# Service Objects
Resource         ../keywords/services/auth_service.robot
Resource         ../keywords/services/movies_service.robot
Resource         ../keywords/services/reservations_service.robot

# Helpers
Resource         ../keywords/helpers/api_helpers.robot
Resource         ../keywords/helpers/validation_helpers.robot

# Keywords específicas
Resource         ../keywords/data_management.robot
Resource         ../keywords/web_keywords.robot

# Variáveis globais
Variables        ../variables/config.robot

*** Keywords ***
Setup API Tests
    [Documentation]    Setup padrão para testes de API
    Setup API Session
    Configurar Dados Básicos de Teste

Setup Web Tests  
    [Documentation]    Setup padrão para testes Web
    Abrir Navegador

Teardown Tests
    [Documentation]    Teardown padrão para todos os testes
    Log    Test completed successfully

Teardown Web Tests
    [Documentation]    Teardown específico para testes web
    Fechar Navegador