*** Settings ***
Documentation    Page Object para página de filmes
Library          Browser

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
    Wait For Elements State    ${MOVIE_CARD}    visible    timeout=10s

Verify Movies List Loaded
    Get Element Count    ${MOVIE_CARD}    >    0

Click First Movie
    Click    ${MOVIE_CARD} >> nth=0

Search Movie
    [Arguments]    ${movie_name}
    Fill Text    ${SEARCH_INPUT}    ${movie_name}
    Keyboard Key    press    Enter

Filter By Genre
    [Arguments]    ${genre}
    Select Options By    ${GENRE_FILTER}    text    ${genre}