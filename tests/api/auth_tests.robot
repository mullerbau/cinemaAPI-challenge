*** Settings ***
Documentation    Testes de autenticação da API Cinema App
Resource         ../resources/base.robot
Test Setup       Setup API Tests
Test Teardown    Teardown Tests

*** Test Cases ***
CT-API-001 - Login com credenciais válidas
    [Documentation]    Valida login com usuário e senha corretos
    [Tags]    api    auth    positive    smoke    critical
    
    # Garante que usuário existe para o teste
    Preparar Usuário Para Teste Positivo    ${TEST_USER_NAME}    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    
    ${response}=    Login User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Validate Success Response    ${response}    200
    
    # Valida estrutura da resposta
    ${response_data}=    Set Variable    ${response.json()}
    Should Contain    ${response_data}    data
    Should Contain    ${response_data['data']}    token
    Should Contain    ${response_data['data']}    _id
    Should Contain    ${response_data['data']}    name
    Should Contain    ${response_data['data']}    email
    
    # Valida dados do usuário
    Should Be Equal As Strings    ${response_data['data']['email']}    ${TEST_USER_EMAIL}
    Should Be Equal As Strings    ${response_data['data']['name']}    ${TEST_USER_NAME}

CT-API-002 - Login com credenciais inválidas
    [Documentation]    Valida erro ao usar email/senha incorretos
    [Tags]    api    auth    negative    security
    
    ${response}=    Login User    ${INVALID_EMAIL}    ${INVALID_PASSWORD}
    Validate Error Response    ${response}    400

CT-API-003 - Login com campos obrigatórios vazios
    [Documentation]    Valida erro ao não informar email ou senha
    [Tags]    api    auth    negative    validation
    
    # Teste sem email
    ${response}=    Login User    ${EMPTY}    ${TEST_USER_PASSWORD}
    Validate Error Response    ${response}    400
    
    # Teste sem senha
    ${response}=    Login User    ${TEST_USER_EMAIL}    ${EMPTY}
    Validate Error Response    ${response}    400

CT-API-004 - Registro de usuário válido
    [Documentation]    Valida criação de novo usuário
    [Tags]    api    auth    positive    crud    critical
    
    # Limpa usuário se existir (para garantir teste limpo)
    Limpar Usuário de Teste    ${TEST_USER_EMAIL}
    
    ${response}=    Register User    ${TEST_USER_NAME}    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    Validate Success Response    ${response}    201
    
    # Valida estrutura da resposta
    ${response_data}=    Set Variable    ${response.json()}
    Should Contain    ${response_data}    data
    Should Contain    ${response_data['data']}    token
    Should Contain    ${response_data['data']}    _id
    
    # Valida dados do usuário criado
    Should Be Equal As Strings    ${response_data['data']['email']}    ${TEST_USER_EMAIL}
    Should Be Equal As Strings    ${response_data['data']['name']}    ${TEST_USER_NAME}

CT-API-005 - Registro com email já existente
    [Documentation]    Valida erro ao tentar registrar email duplicado
    [Tags]    api    auth    negative    validation    business_rule
    
    # Garante que usuário existe para o teste falhar
    Preparar Usuário Para Teste Positivo    Bauer Duplicado    ${DUP_USER_EMAIL}    ${TEST_USER_PASSWORD}
    
    # Tenta registrar novamente com mesmo email
    ${response}=    Register User    Outro Nome    ${DUP_USER_EMAIL}    outrasenha123
    Validate Error Response    ${response}    400    already exists

CT-API-006 - Obter perfil com token válido
    [Documentation]    Valida obtenção de perfil com autenticação
    [Tags]    api    auth    positive    jwt    protected
    
    # Prepara usuário e faz login para obter token
    Preparar Usuário Para Teste Positivo    ${TEST_USER_NAME}    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${login_response}=    Login User    ${TEST_USER_EMAIL}    ${TEST_USER_PASSWORD}
    ${token}=    Extract Token From Login Response    ${login_response}
    
    # Obtém perfil com token
    ${response}=    Get User Profile    ${token}
    Validate Success Response    ${response}    200
    
    # Valida dados do perfil
    ${profile_data}=    Set Variable    ${response.json()['data']}
    Validate User Structure    ${profile_data}
    Should Be Equal As Strings    ${profile_data['email']}    ${TEST_USER_EMAIL}

CT-API-007 - Obter perfil sem token
    [Documentation]    Valida erro ao acessar perfil sem autenticação
    [Tags]    api    auth    negative    security    unauthorized
    
    ${response}=    Get User Profile Without Token
    Validate Error Response    ${response}    401

CT-API-008 - Obter perfil com token inválido
    [Documentation]    Valida erro ao usar token inválido
    [Tags]    api    auth    negative    security    jwt    unauthorized
    
    ${invalid_token}=    Set Variable    eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.invalid.token
    ${response}=    Get User Profile    ${invalid_token}
    Validate Error Response    ${response}    401