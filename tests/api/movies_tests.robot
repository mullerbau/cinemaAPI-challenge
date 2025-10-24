*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Movies Service
Suite Teardown    Cleanup Test Data
Test Tags    api    movies

*** Test Cases ***
Movies-001: Get All Movies Successfully
    [Documentation]    Testa listagem de todos os filmes
    [Tags]    positive    smoke    critical
    ${response}=    Get All Movies
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data
    ${movies}=    Get From Dictionary    ${response.json()}    data
    Should Not Be Empty    ${movies}

Movies-002: Get Movie By Valid ID
    [Documentation]    Testa busca de filme por ID válido
    [Tags]    positive    critical
    ${all_movies}=    Get All Movies
    ${movies}=    Get From Dictionary    ${all_movies.json()}    data
    ${first_movie}=    Get From List    ${movies}    0
    ${movie_id}=    Get From Dictionary    ${first_movie}    _id
    ${response}=    Get Movie By ID    ${movie_id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data
    ${movie}=    Get From Dictionary    ${response.json()}    data
    Should Be Equal    ${movie}[_id]    ${movie_id}

Movies-003: Get Movie By Invalid ID
    [Documentation]    Testa busca de filme com ID inválido
    [Tags]    negative    validation
    ${response}=    Get Movie By ID    invalid_id
    Should Be Equal As Integers    ${response.status_code}    404

Movies-004: Get Movie Sessions Successfully
    [Documentation]    Testa listagem de sessões de um filme
    [Tags]    positive    critical
    ${all_movies}=    Get All Movies
    ${movies}=    Get From Dictionary    ${all_movies.json()}    data
    ${first_movie}=    Get From List    ${movies}    0
    ${movie_id}=    Get From Dictionary    ${first_movie}    _id
    ${response}=    Get Movie Sessions    ${movie_id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data

Movies-005: Get Sessions For Invalid Movie
    [Documentation]    Testa busca de sessões para filme inexistente
    [Tags]    negative    validation
    ${response}=    Get Movie Sessions    invalid_movie_id
    Should Be Equal As Integers    ${response.status_code}    404

Movies-006: Validate Movie Data Structure
    [Documentation]    Valida estrutura dos dados do filme
    [Tags]    positive    validation
    ${response}=    Get All Movies
    ${movies}=    Get From Dictionary    ${response.json()}    data
    ${first_movie}=    Get From List    ${movies}    0
    Should Contain    ${first_movie}    _id
    Should Contain    ${first_movie}    title
    Should Contain    ${first_movie}    genres
    Should Contain    ${first_movie}    duration

Movies-007: Search Movies By Genre
    [Documentation]    Testa busca de filmes por gênero
    [Tags]    positive    search
    ${response}=    Search Movies By Genre    Action
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data

Movies-008: Get Movie Availability
    [Documentation]    Testa verificação de disponibilidade do filme
    [Tags]    positive    business
    ${all_movies}=    Get All Movies
    ${movies}=    Get From Dictionary    ${all_movies.json()}    data
    ${first_movie}=    Get From List    ${movies}    0
    ${movie_id}=    Get From Dictionary    ${first_movie}    _id
    ${response}=    Check Movie Availability    ${movie_id}
    Should Be Equal As Integers    ${response.status_code}    200
    Should Contain    ${response.json()}    data