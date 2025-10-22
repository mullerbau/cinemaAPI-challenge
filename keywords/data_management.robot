*** Settings ***
Library    ../utils/data_manager.py
Variables  ../variables/config.robot

*** Keywords ***
Limpar Usuário de Teste
    [Arguments]    ${email}
    [Documentation]    Remove usuário específico antes do teste
    Clean User From Database    ${email}

Limpar Filme de Teste
    [Arguments]    ${title}
    [Documentation]    Remove filme específico antes do teste
    Clean Movie From Database    movie_title=${title}

Configurar Dados Básicos de Teste
    [Documentation]    Configura usuários e filmes básicos para testes
    Setup Basic Test Data

Limpar Todos os Dados de Teste
    [Documentation]    Remove todos os dados de teste (usar com cuidado)
    Clean All Test Data

Preparar Usuário Para Teste Positivo
    [Arguments]    ${name}    ${email}    ${password}    ${role}=user
    [Documentation]    Limpa e cria usuário para teste de sucesso
    ${user_id}=    Create Test User    ${name}    ${email}    ${password}    ${role}
    RETURN    ${user_id}

Preparar Usuário Para Teste Negativo
    [Arguments]    ${email}
    [Documentation]    Garante que usuário existe para teste de falha (email já existe)
    ${user}=    Get User By Email    ${email}
    Should Not Be Empty    ${user}    Usuário deve existir para teste negativo

Preparar Filme Para Teste
    [Arguments]    ${title}    ${synopsis}    ${director}    ${genre}    ${duration}    ${classification}
    [Documentation]    Limpa e cria filme para teste
    ${movie_id}=    Create Test Movie    ${title}    ${synopsis}    ${director}    ${genre}    ${duration}    ${classification}
    RETURN    ${movie_id}

Obter ID do Usuário Por Email
    [Arguments]    ${email}
    [Documentation]    Retorna ID do usuário pelo email
    ${user}=    Get User By Email    ${email}
    Should Not Be Empty    ${user}    Usuário não encontrado: ${email}
    RETURN    ${user['_id']}

Obter ID do Filme Por Título
    [Arguments]    ${title}
    [Documentation]    Retorna ID do filme pelo título
    ${movie}=    Get Movie By Title    ${title}
    Should Not Be Empty    ${movie}    Filme não encontrado: ${title}
    RETURN    ${movie['_id']}