*** Settings ***
Resource    ../../keywords/api_keywords.robot
Resource    ../../keywords/web_keywords.robot
Resource    ../../libs/database_keywords.robot
Variables   ../../variables/config.robot

*** Keywords ***
Setup Test Environment
    Setup API Session
    Setup Clean Database
    
Teardown Test Environment
    Teardown Database
    Log    Test completed

Setup Web Test
    Setup Clean Database
    Abrir Navegador
    
Teardown Web Test
    Fechar Navegador
    Teardown Database

Setup Web Test With Clean DB
    [Documentation]    Setup para testes web com limpeza de banco
    Setup Clean Database
    Abrir Navegador
    
Teardown Web Test With Clean DB
    [Documentation]    Teardown para testes web com limpeza final
    Fechar Navegador
    Teardown Database