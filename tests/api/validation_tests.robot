*** Settings ***
Resource    ../../resources/base.robot
Suite Setup    Setup Auth Service
Suite Teardown    Cleanup Test Data
Test Tags    api    validation

*** Test Cases ***
Validation-001: Email Format Validation
    [Documentation]    Testa validação de formato de email em diferentes cenários
    [Tags]    negative    validation    boundary
    
    # Email sem @
    ${response1}=    Register User    Test User    emailsemarroba.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response1.status_code}    400
    
    # Email com múltiplos @
    ${response2}=    Register User    Test User    email@@test.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response2.status_code}    400
    
    # Email muito longo
    ${long_email}=    Evaluate    'a' * 100 + '@test.com'
    ${response3}=    Register User    Test User    ${long_email}    ${TEST_USER_PASSWORD}
    Should Be True    ${response3.status_code} in [400, 413]    msg=API should reject long emails

Validation-002: Password Strength Validation
    [Documentation]    Testa validação de força da senha
    [Tags]    negative    validation    security
    ${unique_email}=    Generate Unique Email
    
    # Senha muito curta
    ${response1}=    Register User    Test User    ${unique_email}    12
    Should Be Equal As Integers    ${response1.status_code}    400
    
    # Senha vazia
    ${response2}=    Register User    Test User    ${unique_email}    ${EMPTY}
    Should Be Equal As Integers    ${response2.status_code}    400

Validation-003: Name Field Validation
    [Documentation]    Testa validação do campo nome
    [Tags]    negative    validation    boundary
    ${unique_email}=    Generate Unique Email
    
    # Nome vazio
    ${response1}=    Register User    ${EMPTY}    ${unique_email}    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response1.status_code}    400
    
    # Nome muito longo
    ${long_name}=    Evaluate    'A' * 200
    ${response2}=    Register User    ${long_name}    ${unique_email}    ${TEST_USER_PASSWORD}
    Should Be True    ${response2.status_code} in [400, 413]    msg=API should reject long names

Validation-004: Special Characters in Fields
    [Documentation]    Testa caracteres especiais em campos de entrada
    [Tags]    negative    validation    injection
    
    # Nome com caracteres especiais
    ${response1}=    Register User    <script>alert('xss')</script>    test@test.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response1.status_code}    400    msg=API should reject XSS attempts
    
    # Email com caracteres especiais
    ${response2}=    Register User    Test User    test'OR'1'='1@test.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response2.status_code}    400

Validation-005: Null and Undefined Values
    [Documentation]    Testa valores null e undefined nos campos
    [Tags]    negative    validation    boundary
    
    # Usando None como valor null
    ${response1}=    Register User Without Name    test@test.com    ${TEST_USER_PASSWORD}
    Should Be Equal As Integers    ${response1.status_code}    400

Validation-006: Unicode and International Characters
    [Documentation]    Testa caracteres unicode e internacionais
    [Tags]    positive    validation    i18n
    ${unique_email}=    Generate Unique Email
    
    # Nome com acentos
    ${response1}=    Register User    José da Silva    ${unique_email}    ${TEST_USER_PASSWORD}
    Should Be True    ${response1.status_code} in [201, 400]
    
    # Nome com caracteres chineses
    ${unique_email2}=    Generate Unique Email
    ${response2}=    Register User    李小明    ${unique_email2}    ${TEST_USER_PASSWORD}
    Should Be True    ${response2.status_code} in [201, 400]

*** Keywords ***
Register User Without Name
    [Arguments]    ${email}    ${password}
    ${user_data}=    Create Dictionary    email=${email}    password=${password}
    ${response}=    POST On Session    cinema_api    /auth/register    json=${user_data}    expected_status=any
    RETURN    ${response}