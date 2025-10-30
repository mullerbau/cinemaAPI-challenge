*** Variables ***
# URLs da aplicação
${BASE_URL_API}        http://localhost:3000/api/v1
${WEB_BASE_URL}        http://localhost:3002

# Credenciais de teste existentes
${VALID_EMAIL}         user@example.com
${VALID_PASSWORD}      user123
${ADMIN_EMAIL}         admin@example.com
${ADMIN_PASSWORD}      admin123

# Dados de teste estáticos para automação
${TEST_USER_NAME}      Bauer Teste
${TEST_USER_EMAIL}     bauer@teste.com
${TEST_USER_PASSWORD}  teste123

# Dados para testes negativos
${DUP_USER_EMAIL}      bauerdup@teste.com
${INVALID_EMAIL}       bauerinvalid@teste.com
${INVALID_PASSWORD}    senhaerrada123

# Configurações do browser
${BROWSER}             chromium
${HEADLESS}            False
${TIMEOUT}             10s

# Headers da API
&{API_HEADERS}         Content-Type=application/json