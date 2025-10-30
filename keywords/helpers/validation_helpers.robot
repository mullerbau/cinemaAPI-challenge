*** Settings ***
Documentation    Keywords para validações padronizadas
Library          JSONLibrary

*** Keywords ***
Validate Success Response
    [Documentation]    Valida resposta de sucesso da API
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Should Not Be Empty    ${response.json()}
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be True    ${success[0]}

Validate Error Response
    [Documentation]    Valida resposta de erro da API
    [Arguments]    ${response}    ${expected_status}    ${expected_message}=${None}
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    ${success}=    Get Value From Json    ${response.json()}    $.success
    Should Be Equal    ${success[0]}    ${False}
    IF    '${expected_message}' != '${None}'
        ${error_message}=    Get Value From Json    ${response.json()}    $.message
        Should Contain    ${error_message[0]}    ${expected_message}
    END

Validate Movie Structure
    [Documentation]    Valida estrutura obrigatória de um filme
    [Arguments]    ${movie}
    Should Contain    ${movie}    _id
    Should Contain    ${movie}    title
    Should Contain    ${movie}    synopsis
    Should Contain    ${movie}    director
    Should Contain    ${movie}    genres
    Should Contain    ${movie}    duration
    Should Contain    ${movie}    classification

Validate User Structure
    [Documentation]    Valida estrutura obrigatória de um usuário
    [Arguments]    ${user}
    Should Contain    ${user}    _id
    Should Contain    ${user}    name
    Should Contain    ${user}    email
    Should Contain    ${user}    role

Validate Reservation Structure
    [Documentation]    Valida estrutura obrigatória de uma reserva
    [Arguments]    ${reservation}
    Should Contain    ${reservation}    _id
    Should Contain    ${reservation}    user
    Should Contain    ${reservation}    session
    Should Contain    ${reservation}    seats
    Should Contain    ${reservation}    totalPrice
    Should Contain    ${reservation}    status