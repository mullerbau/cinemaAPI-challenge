*** Settings ***
Resource    ../../variables/config.robot
Resource    ../../keywords/pages/login_page.robot
Resource    ../../keywords/pages/movies_page.robot
Resource    ../../keywords/pages/reservation_page.robot
Library     Browser
Suite Setup    Setup Web Suite
Suite Teardown    Teardown Web Suite
Test Tags    web    reservations
Test Timeout    30s

*** Keywords ***
Setup Web Suite
    New Browser    chromium    headless=false
    Set Browser Timeout    10s

Teardown Web Suite
    Close Browser

*** Test Cases ***
Web-Reservation-001: Navigate To Reservation Page
    [Documentation]    Testa navegação para página de reserva
    [Tags]    positive    navigation    critical
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation

Web-Reservation-002: Access Reservation With Login
    [Documentation]    Testa acesso à reserva com login
    [Tags]    positive    auth
    Open Login Page
    Fill Login Form    joao@teste.com    123456
    Click Login Button
    Verify Login Success
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation

Web-Reservation-003: Back Link Navigation
    [Documentation]    Testa navegação pelo link voltar
    [Tags]    positive    navigation
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Click    css=.back-link
    Sleep    2s

Web-Reservation-004: Multiple Movie Reservations
    [Documentation]    Testa navegação para reserva de diferentes filmes
    [Tags]    positive    navigation
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Click    css=.back-link
    Sleep    2s
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation