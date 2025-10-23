*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables  ../variables/config.robot

*** Keywords ***
Setup Movies Service
    Create Session    cinema_api    ${BASE_URL_API}    headers=${API_HEADERS}

Get All Movies
    ${response}=    GET On Session    cinema_api    /movies
    RETURN    ${response}

Get Movie By ID
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}
    RETURN    ${response}

Get Movie By ID With Error Handling
    [Arguments]    ${movie_id}
    ${response}=    GET On Session    cinema_api    /movies/${movie_id}    expected_status=any
    RETURN    ${response}

Validate Movie Structure
    [Arguments]    ${movie}
    Should Contain    ${movie}    _id
    Should Contain    ${movie}    title
    Should Contain    ${movie}    synopsis
    Should Contain    ${movie}    director
    Should Contain    ${movie}    genres
    Should Contain    ${movie}    duration
    Should Contain    ${movie}    classification

Get First Movie ID From List
    [Arguments]    ${movies_response}
    ${movies}=    Set Variable    ${movies_response.json()}
    Should Not Be Empty    ${movies}    No movies found in response
    ${first_movie_id}=    Get Value From Json    ${movies}    $[0]._id
    RETURN    ${first_movie_id[0]}