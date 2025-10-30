*** Settings ***
Documentation    Service Object para operações de filmes
Library          RequestsLibrary
Library          JSONLibrary
Resource         ../../variables/config.robot

*** Keywords ***
Setup Movies Session
    [Documentation]    Configura sessão para endpoints de filmes
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Get All Movies
    [Documentation]    Lista todos os filmes disponíveis
    ${response}=    GET On Session    cinema_api    /movies    expected_status=any
    RETURN    ${response}

Get Movie By ID
    [Documentation]    Busca filme específico por ID
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}    expected_status=any
    RETURN    ${response}

Get First Movie ID From Response
    [Documentation]    Extrai ID do primeiro filme da lista
    [Arguments]    ${movies_response}
    ${movies}=    Set Variable    ${movies_response.json()}
    Should Not Be Empty    ${movies}    Lista de filmes está vazia
    ${first_movie_id}=    Get Value From Json    ${movies}    $[0]._id
    RETURN    ${first_movie_id[0]}

Get Movie Sessions
    [Documentation]    Busca sessões de um filme específico
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}/sessions    expected_status=any
    RETURN    ${response}

Search Movies By Genre
    [Documentation]    Busca filmes por gênero
    [Arguments]    ${genre}
    ${params}=    Create Dictionary    genre=${genre}
    ${response}=    GET On Session    cinema_api    /movies    params=${params}    expected_status=any
    RETURN    ${response}

Check Movie Availability
    [Documentation]    Verifica disponibilidade de um filme
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}/availability    expected_status=any
    RETURN    ${response}

Get All Sessions
    [Documentation]    Lista todas as sessões disponíveis
    ${response}=    GET On Session    cinema_api    /sessions    expected_status=any
    RETURN    ${response}

Get Session By ID
    [Documentation]    Busca sessão por ID
    [Arguments]    ${session_id}
    ${response}=    GET On Session    cinema_api    /sessions/${session_id}    expected_status=any
    RETURN    ${response}