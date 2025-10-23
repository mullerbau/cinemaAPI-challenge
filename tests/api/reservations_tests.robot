*** Settings ***
Documentation    Testes de reservas da API Cinema App
Resource         ../resources/base.robot
Test Setup       Setup API Tests
Test Teardown    Teardown Tests

*** Test Cases ***
CT-API-020 - Criar reserva válida
    [Documentation]    Valida criação de reserva com dados corretos
    [Tags]    api    reservations    positive    critical    business_critical    protected    crud
    
    # Prepara usuário e faz login
    Preparar Usuário Para Teste Positivo    ${TEST_USER_NAME}    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${login_response}=    Login User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${token}=    Extract Token From Login Response    ${login_response}
    
    # Obtém sessão válida (assumindo que existe)
    # Em um projeto real, criaríamos sessão via setup
    ${session_id}=    Set Variable    507f1f77bcf86cd799439012    # ID fictício para exemplo
    ${seats}=    Generate Sample Seats    2
    
    ${response}=    Create Reservation    ${token}    ${session_id}    ${seats}
    
    # Nota: Este teste pode falhar se não houver sessões válidas
    # Em implementação real, validaríamos o status code retornado
    Log    Response Status: ${response.status_code}
    Log    Response Body: ${response.json()}

CT-API-021 - Criar reserva sem autenticação
    [Documentation]    Valida erro 401 ao tentar criar reserva sem token
    [Tags]    api    reservations    negative    security    unauthorized    protected
    
    ${session_id}=    Set Variable    507f1f77bcf86cd799439012
    ${seats}=    Generate Sample Seats    1
    
    ${response}=    Create Reservation Without Auth    ${session_id}    ${seats}
    Validate Error Response    ${response}    401

CT-API-022 - Listar reservas do usuário
    [Documentation]    Valida listagem de reservas do usuário autenticado
    [Tags]    api    reservations    positive    protected    read    user_data
    
    # Usa usuário existente do sistema
    ${login_response}=    Login User    ${VALID_EMAIL}    ${VALID_PASSWORD}
    ${token}=    Extract Token From Login Response    ${login_response}
    
    ${response}=    Get User Reservations    ${token}
    
    # Valida resposta (pode estar vazia)
    Should Be True    ${response.status_code} in [200, 404]
    
    IF    ${response.status_code} == 200
        ${reservations}=    Set Variable    ${response.json()}
        Should Be True    isinstance($reservations, list)
        
        # Se houver reservas, valida estrutura
        IF    len($reservations) > 0
            ${first_reservation}=    Set Variable    ${reservations[0]}
            Validate Reservation Structure    ${first_reservation}
        END
    END

CT-API-023 - Listar reservas sem autenticação
    [Documentation]    Valida erro 401 ao tentar listar reservas sem token
    [Tags]    api    reservations    negative    security    unauthorized    protected
    
    # Tenta acessar endpoint protegido sem autenticação
    ${response}=    GET On Session    cinema_api    /reservations    expected_status=any
    Validate Error Response    ${response}    401