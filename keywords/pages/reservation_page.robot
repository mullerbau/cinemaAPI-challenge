*** Settings ***
Documentation    Page Object para página de reservas
Library          Browser

*** Variables ***
${SEAT_AVAILABLE}         css=.seat.available
${SEAT_SELECTED}          css=.seat.selected
${SEAT_OCCUPIED}          css=.seat.occupied
${CONFIRM_BUTTON}         css=.confirm-reservation
${PAYMENT_FORM}           css=.payment-form
${SUCCESS_MESSAGE}        css=.reservation-success

*** Keywords ***
Select Available Seat
    [Arguments]    ${seat_number}=1
    Click    ${SEAT_AVAILABLE} >> nth=${seat_number - 1}

Verify Seat Selected
    [Arguments]    ${seat_number}=1
    Get Element Count    ${SEAT_SELECTED}    >=    ${seat_number}

Click Confirm Reservation
    Click    ${CONFIRM_BUTTON}

Fill Payment Form
    [Arguments]    ${card_number}    ${cvv}    ${expiry}
    Fill Text    id=card-number    ${card_number}
    Fill Text    id=cvv    ${cvv}
    Fill Text    id=expiry    ${expiry}

Verify Reservation Success
    Wait For Elements State    ${SUCCESS_MESSAGE}    visible    timeout=10s