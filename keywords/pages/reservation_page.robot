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