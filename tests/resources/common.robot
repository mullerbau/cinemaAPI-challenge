*** Settings ***
Resource    ../../keywords/api_keywords.robot
Resource    ../../keywords/web_keywords.robot
Variables   ../../variables/config.robot

*** Keywords ***
Setup Test Environment
    Setup API Session
    
Teardown Test Environment
    # Cleanup se necessário
    Log    Test completed

Setup Web Test
    Abrir Navegador
    
Teardown Web Test
    Fechar Navegador