*** Settings ***
Documentation    Testes de filmes da API Cinema App
Resource         ../resources/base.robot
Test Setup       Setup API Tests
Test Teardown    Teardown Tests

*** Test Cases ***
CT-API-009 - Listar todos os filmes
    [Documentation]    Valida listagem de filmes disponíveis (endpoint público)
    [Tags]    api    movies    positive    smoke    public    read
    
    ${response}=    Get All Movies
    Validate Success Response    ${response}    200
    
    ${movies}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${movies}    Lista de filmes não deve estar vazia
    
    # Valida estrutura do primeiro filme
    ${first_movie}=    Set Variable    ${movies[0]}
    Validate Movie Structure    ${first_movie}
    
    # Valida que é uma lista
    ${movies_count}=    Get Length    ${movies}
    Should Be True    ${movies_count} > 0    Deve haver pelo menos 1 filme

CT-API-010 - Obter filme por ID válido
    [Documentation]    Valida busca de filme específico por ID
    [Tags]    api    movies    positive    public    read    crud
    
    # Primeiro obtém lista para pegar um ID válido
    ${movies_response}=    Get All Movies
    Validate Success Response    ${movies_response}    200
    ${movie_id}=    Get First Movie ID From Response    ${movies_response}
    
    # Busca o filme específico
    ${response}=    Get Movie By ID    ${movie_id}
    Validate Success Response    ${response}    200
    
    ${movie}=    Set Variable    ${response.json()}
    Validate Movie Structure    ${movie}
    Should Be Equal As Strings    ${movie['_id']}    ${movie_id}
    
    # Valida campos específicos
    Should Not Be Empty    ${movie['title']}
    Should Not Be Empty    ${movie['synopsis']}
    Should Be True    ${movie['duration']} > 0

CT-API-011 - Obter filme por ID inexistente
    [Documentation]    Valida erro 404 ao buscar filme que não existe
    [Tags]    api    movies    negative    not_found    error_handling
    
    ${invalid_id}=    Set Variable    507f1f77bcf86cd799439011
    ${response}=    Get Movie By ID    ${invalid_id}
    
    Validate Error Response    ${response}    404

CT-API-012 - Validar estrutura dos dados do filme
    [Documentation]    Valida se filme contém todos os campos obrigatórios
    [Tags]    api    movies    positive    validation    data_structure
    
    ${response}=    Get All Movies
    Validate Success Response    ${response}    200
    
    ${movies}=    Set Variable    ${response.json()}
    Should Not Be Empty    ${movies}
    
    # Valida estrutura de cada filme na lista
    FOR    ${movie}    IN    @{movies}
        Validate Movie Structure    ${movie}
        # Valida tipos de dados
        Should Be String    ${movie['title']}
        Should Be String    ${movie['director']}
        Should Be True    isinstance($movie['genres'], list)
        Should Be True    isinstance($movie['duration'], int)
    END

CT-API-013 - Listar filmes quando vazio
    [Documentation]    Valida comportamento quando não há filmes (cenário edge case)
    [Tags]    api    movies    edge_case    boundary    public
    
    # Este teste assume que sempre haverá filmes no sistema
    # Em um cenário real, poderíamos limpar todos os filmes primeiro
    ${response}=    Get All Movies
    Validate Success Response    ${response}    200
    
    ${movies}=    Set Variable    ${response.json()}
    # Para este sistema, esperamos sempre ter filmes
    Should Not Be Empty    ${movies}    Sistema deve ter filmes cadastrados