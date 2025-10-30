*** Settings ***
Resource    ../../variables/config.robot
Library     Browser

*** Keywords ***
Open Movies Page
    New Page    ${WEB_BASE_URL}/movies

Verify Movies Page Loaded
    Wait For Elements State    //*[@id="root"]/main/div/h1    visible    timeout=10s
    ${title}=    Get Text    //*[@id="root"]/main/div/h1
    Should Contain Any    ${title}    Movies    Filmes

Verify Movies List Loaded
    Wait For Elements State    css=.movie-card >> nth=0    visible    timeout=10s
    ${count}=    Get Element Count    css=.movie-card
    Should Be True    ${count} > 0

Click First Movie
    Click    css=.movie-card >> nth=0

Click Movie Details Button
    Click    //*[@id="root"]/main/div/div[2]/div[1]/div[2]/a

Verify Movie Details Page
    Wait For Elements State    css=.movie-detail-header    visible    timeout=10s

Search Movie
    [Arguments]    ${movie_title}
    Fill Text    css=input[placeholder="Buscar filmes..."]    ${movie_title}
    Sleep    1s

Filter By Genre
    [Arguments]    ${genre}
    Click    css=.genre-filter
    Sleep    1s
    Wait For Elements State    css=[value="${genre}"]    visible    timeout=5s
    Click    css=[value="${genre}"]
    Sleep    1s

Verify No Results
    Wait For Elements State    css=.no-results    visible    timeout=5s