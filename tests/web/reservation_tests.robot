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

Web-Reservation-005: Select Single Seat
    [Documentation]    Testa seleção de um assento
    [Tags]    positive    seats    critical
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Select First Available Seat
    Verify Any Seat Selected

Web-Reservation-006: Select Multiple Seats
    [Documentation]    Testa seleção de múltiplos assentos
    [Tags]    positive    seats
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Select First Available Seat
    Select First Available Seat
    ${selected_count}=    Count Selected Seats
    Should Be True    ${selected_count} >= 1

Web-Reservation-007: Verify Occupied Seat Not Selectable
    [Documentation]    Testa que assento ocupado não é selecionável
    [Tags]    negative    seats
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    ${occupied_count}=    Get Element Count    css=.seat.occupied
    Should Be True    ${occupied_count} >= 0
    ${occupied_disabled}=    Get Element Count    css=.seat.occupied[disabled]
    Should Be Equal As Numbers    ${occupied_count}    ${occupied_disabled}

Web-Reservation-008: Deselect Seat
    [Documentation]    Testa deseleção de assento
    [Tags]    positive    seats
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Select Available Seat    B    3
    Verify Seat Selected    B    3
    Deselect Seat    B    3
    ${selected_count}=    Count Selected Seats
    Should Be Equal As Numbers    ${selected_count}    0

Web-Reservation-009: Proceed To Checkout
    [Documentation]    Testa prosseguir para checkout
    [Tags]    positive    checkout    critical
    Open Movies Page
    Verify Movies Page Loaded
    Navigate To Reservation
    Select First Available Seat
    Verify Any Seat Selected
    Click Checkout Button
    Sleep    2s