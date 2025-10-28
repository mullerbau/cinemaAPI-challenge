*** Settings ***
Resource    ../../resources/base.robot
Resource    ../../keywords/pages/login_page.robot
Resource    ../../keywords/pages/movies_page.robot
Resource    ../../keywords/pages/reservation_page.robot
Suite Setup    New Browser    chromium    headless=false
Suite Teardown    Close Browser
Test Tags    web    reservations

*** Test Cases ***
Web-Reservation-001: Complete Reservation Flow
    [Documentation]    Testa fluxo completo de reserva
    [Tags]    positive    e2e    critical
    Open Login Page
    Fill Login Form    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Click Login Button
    Verify Login Success
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Verify Seat Selected    1
    Click Confirm Reservation
    Fill Payment Form    4111111111111111    123    12/25
    Verify Reservation Success

Web-Reservation-002: Select Multiple Seats
    [Documentation]    Testa seleção de múltiplos assentos
    [Tags]    positive    seats
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Select Available Seat    2
    Verify Seat Selected    2

Web-Reservation-003: Attempt Select Occupied Seat
    [Documentation]    Testa tentativa de selecionar assento ocupado
    [Tags]    negative    seats
    Open Movies Page
    Click First Movie
    Click    ${SEAT_OCCUPIED} >> nth=0
    Get Element Count    ${SEAT_SELECTED}    ==    0

Web-Reservation-004: Reservation Without Login
    [Documentation]    Testa tentativa de reserva sem login
    [Tags]    negative    auth
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Click Confirm Reservation
    Wait For Elements State    css=.login-required    visible    timeout=5s

Web-Reservation-005: Cancel Seat Selection
    [Documentation]    Testa cancelamento de seleção de assento
    [Tags]    positive    seats
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Click    ${SEAT_SELECTED} >> nth=0    # Deselect
    Get Element Count    ${SEAT_SELECTED}    ==    0

Web-Reservation-006: Payment Form Validation
    [Documentation]    Testa validação do formulário de pagamento
    [Tags]    negative    payment
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Click Confirm Reservation
    Fill Payment Form    invalid    123    12/25
    Click    css=.pay-button
    Wait For Elements State    css=.payment-error    visible    timeout=5s

Web-Reservation-007: Reservation Confirmation Details
    [Documentation]    Testa detalhes na confirmação de reserva
    [Tags]    positive    confirmation
    Open Movies Page
    Click First Movie
    Select Available Seat    1
    Click Confirm Reservation
    Get Text    css=.reservation-summary    contains    Seat A1
    Get Text    css=.total-price    contains    $