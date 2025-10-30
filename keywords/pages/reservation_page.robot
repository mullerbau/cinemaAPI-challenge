*** Settings ***
Resource    ../../variables/config.robot
Library     Browser

*** Keywords ***
Click Session Button
    Click    css=.btn.btn-primary.session-button

Verify Reservation Page
    Wait For Elements State    css=.back-link    visible    timeout=10s

Navigate To Reservation
    Click Movie Details Button
    Verify Movie Details Page
    Click Session Button
    Verify Reservation Page

Select Available Seat
    [Arguments]    ${row}    ${seat_number}
    Click    css=.seat.available[title*="Fileira ${row}, Assento ${seat_number} - Status: available"]

Select First Available Seat
    Click    css=.seat.available >> nth=0

Verify Seat Selected
    [Arguments]    ${row}    ${seat_number}
    Wait For Elements State    css=.seat.selected[title*="Fileira ${row}, Assento ${seat_number} - Status: selected"]    visible    timeout=5s

Verify Any Seat Selected
    Wait For Elements State    css=.seat.selected    visible    timeout=5s

Click Occupied Seat
    Click    css=.seat.occupied >> nth=0

Click Checkout Button
    Click    css=.btn.btn-primary.checkout-button

Deselect Seat
    [Arguments]    ${row}    ${seat_number}
    Click    css=.seat.selected[title*="Fileira ${row}, Assento ${seat_number} - Status: selected"]

Count Available Seats
    ${count}=    Get Element Count    css=.seat.available
    RETURN    ${count}

Count Selected Seats
    ${count}=    Get Element Count    css=.seat.selected
    RETURN    ${count}