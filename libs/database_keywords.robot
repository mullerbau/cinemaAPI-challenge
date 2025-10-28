*** Settings ***
Documentation    Keywords para limpeza e setup do banco de dados
Library          Process
Library          OperatingSystem

*** Keywords ***
Cleanup Database
    [Documentation]    Executa limpeza do banco MongoDB
    ${result}=    Run Process    python    libs/mongodb_cleanup.py    cwd=${CURDIR}/..
    Log    Database cleanup result: ${result.stdout}
    Should Be Equal As Integers    ${result.rc}    0    Database cleanup failed: ${result.stderr}

Setup Clean Database
    [Documentation]    Prepara banco limpo para testes
    Cleanup Database
    Log    Database ready for tests

Teardown Database
    [Documentation]    Limpeza final após testes
    Cleanup Database
    Log    Database cleaned after tests