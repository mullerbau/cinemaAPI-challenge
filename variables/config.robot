*** Variables ***
# URLs da aplicação
${BASE_URL_API}        http://localhost:3000/api/v1
${WEB_BASE_URL}        http://localhost:3002

# Credenciais de teste
${VALID_EMAIL}         user@example.com
${VALID_PASSWORD}      user123
${ADMIN_EMAIL}         admin@example.com
${ADMIN_PASSWORD}      admin123

# Dados de teste
${TEST_USER_NAME}      Usuário Teste
${TEST_USER_EMAIL}     teste@cinema.com
${TEST_USER_PASSWORD}  teste123

# Configurações do browser
${BROWSER}             chromium
${HEADLESS}            False
${TIMEOUT}             10s

# Headers da API
&{API_HEADERS}         Content-Type=application/json