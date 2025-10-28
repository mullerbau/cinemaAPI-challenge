*** Settings ***
Resource    variables/config.robot
Library     Browser

*** Test Cases ***
Debug Movies Page
    [Documentation]    Debug para descobrir seletores da página de filmes
    New Browser    chromium    headless=false
    Set Browser Timeout    10s
    
    New Page    ${WEB_BASE_URL}/movies
    Sleep    3s
    
    # Verificar título da página
    ${title}=    Get Text    //*[@id="root"]/main/div/h1
    Log    Título da página: ${title}
    
    # Contar filmes
    ${count}=    Get Element Count    css=.movie-card
    Log    Número de filmes: ${count}
    
    # Verificar se há campo de busca
    ${search_exists}=    Run Keyword And Return Status    Get Element    css=input[type="search"]
    Log    Campo de busca existe: ${search_exists}
    
    ${search_exists2}=    Run Keyword And Return Status    Get Element    css=input[placeholder*="search"]
    Log    Campo de busca (placeholder): ${search_exists2}
    
    ${search_exists3}=    Run Keyword And Return Status    Get Element    css=input
    Log    Qualquer input existe: ${search_exists3}
    
    # Verificar se há select de gênero
    ${genre_exists}=    Run Keyword And Return Status    Get Element    css=select
    Log    Select de gênero existe: ${genre_exists}
    
    Close Browser