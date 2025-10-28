*** Settings ***
Documentation    Page Object para página de filmes
Library          Browser
Resource         ../../variables/config.robot

*** Variables ***
${MOVIES_URL}             ${BASE_URL_WEB}/movies
${MOVIE_CARD}             css=.movie-card
${MOVIE_TITLE}            css=.movie-title
${MOVIE_DETAILS_BUTTON}   css=.view-details
${SEARCH_INPUT}           id=search
${GENRE_FILTER}           css=.genre-filter

*** Keywords ***
Open Movies Page
    New Page    ${MOVIES_URL}
    Wait For Load State    networkidle    timeout=10s
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=10s

Verify Movies List Loaded
    Get Element Count    ${MOVIE_CARD}    >    0

Click First Movie
    Click    ${MOVIE_CARD} >> nth=0
    Wait For Load State    networkidle    timeout=5s

Search Movie
    [Arguments]    ${movie_name}
    Fill Text    ${SEARCH_INPUT}    ${movie_name}
    Keyboard Key    press    Enter
    Wait For Load State    networkidle    timeout=5s

Filter By Genre
    [Arguments]    ${genre}
    Select Options By    ${GENRE_FILTER}    text    ${genre}
    Wait For Load State    networkidle    timeout=5s