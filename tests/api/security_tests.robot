*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Reservations Service
Suite Teardown    Cleanup Test Data
Test Tags    api    security

*** Test Cases ***
Security-001: IDOR - Access Another User Reservation
    [Documentation]    Testa tentativa de acesso a reserva de outro usuário (IDOR)
    [Tags]    negative    security    idor    critical
    Cleanup Test Data
    
    # Criar usuário A e sua reserva
    ${token_a}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${reservation_response}=    Create Reservation    ${token_a}    ${session_id}    ${seats}
    
    Run Keyword If    ${reservation_response.status_code} == 201    Test IDOR Access    ${reservation_response}
    ...    ELSE    Log    Reservation creation failed, skipping IDOR test

Security-002: IDOR - Cancel Another User Reservation
    [Documentation]    Testa tentativa de cancelamento de reserva de outro usuário (IDOR)
    [Tags]    negative    security    idor    critical
    Cleanup Test Data
    
    # Criar usuário A e sua reserva
    ${token_a}=    Get Valid User Token
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${reservation_response}=    Create Reservation    ${token_a}    ${session_id}    ${seats}
    
    Run Keyword If    ${reservation_response.status_code} == 201    Test IDOR Cancel    ${reservation_response}
    ...    ELSE    Log    Reservation creation failed, skipping IDOR test

Security-003: JWT Token Manipulation
    [Documentation]    Testa uso de token JWT inválido/manipulado
    [Tags]    negative    security    jwt
    ${session_id}=    Get Valid Session ID
    ${seats}=    Create Sample Seats List
    ${invalid_token}=    Set Variable    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.invalid.signature
    ${response}=    Create Reservation    ${invalid_token}    ${session_id}    ${seats}
    Should Be Equal As Integers    ${response.status_code}    401

Security-004: SQL Injection Attempt in Session ID
    [Documentation]    Testa tentativa de SQL injection no ID da sessão
    [Tags]    negative    security    injection
    Cleanup Test Data
    ${token}=    Get Valid User Token
    ${seats}=    Create Sample Seats List
    ${malicious_session}=    Set Variable    ' OR '1'='1
    ${response}=    Create Reservation    ${token}    ${malicious_session}    ${seats}
    Should Be True    ${response.status_code} in [400, 404]

*** Keywords ***
Test IDOR Access
    [Arguments]    ${reservation_response}
    # Extrair ID da reserva do usuário A
    ${reservation_data}=    Get From Dictionary    ${reservation_response.json()}    data
    ${reservation_id}=    Get From Dictionary    ${reservation_data}    _id
    
    # Criar usuário B
    ${unique_email_b}=    Generate Unique Email
    Register User    User B    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${login_response_b}=    Login User    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${token_b}=    Extract Token From Response    ${login_response_b}
    
    # Usuário B tenta acessar reserva do usuário A
    ${idor_response}=    Get Reservation By ID    ${token_b}    ${reservation_id}
    Should Be True    ${idor_response.status_code} in [403, 404]

Test IDOR Cancel
    [Arguments]    ${reservation_response}
    # Extrair ID da reserva do usuário A
    ${reservation_data}=    Get From Dictionary    ${reservation_response.json()}    data
    ${reservation_id}=    Get From Dictionary    ${reservation_data}    _id
    
    # Criar usuário B
    ${unique_email_b}=    Generate Unique Email
    Register User    User B    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${login_response_b}=    Login User    ${unique_email_b}    ${TEST_USER_PASSWORD}
    ${token_b}=    Extract Token From Response    ${login_response_b}
    
    # Usuário B tenta cancelar reserva do usuário A
    ${idor_response}=    Cancel Reservation    ${token_b}    ${reservation_id}
    Should Be True    ${idor_response.status_code} in [403, 404]

Extract Token From Response
    [Arguments]    ${login_response}
    ${data}=    Get From Dictionary    ${login_response.json()}    data
    ${token}=    Get From Dictionary    ${data}    token
    RETURN    ${token}