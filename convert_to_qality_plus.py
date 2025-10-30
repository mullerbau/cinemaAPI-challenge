#!/usr/bin/env python3
"""
Script para converter casos de teste para CSV do QAlity Plus
Campos: test case name, descrição, test step, expected result, test data, priority
"""

import csv

def extract_test_cases_qality():
    """Extrai todos os casos de teste no formato QAlity Plus"""
    
    test_cases = []
    
    # API - Autenticação
    test_cases.extend([
        ["Auth-001: Register New User Successfully", "Testa registro de novo usuário com dados válidos", "1. Enviar POST /auth/register com dados válidos\n2. Verificar resposta", "Status 201 e usuário criado com sucesso", "name: João Silva, email: joao@teste.com, password: 123456", "Alta"],
        ["Auth-002: Login With Valid Credentials", "Testa login com credenciais válidas", "1. Enviar POST /auth/login com credenciais válidas\n2. Verificar token retornado", "Status 200 e token JWT válido retornado", "email: admin@example.com, password: admin123", "Crítica"],
        ["Auth-003: Register User With Existing Email", "Testa registro com email já existente", "1. Enviar POST /auth/register com email existente\n2. Verificar erro", "Status 400 e mensagem de erro", "email: admin@example.com (já existe)", "Média"],
        ["Auth-004: Login With Invalid Email", "Testa login com email inválido", "1. Enviar POST /auth/login com email inválido\n2. Verificar erro", "Status 401 e mensagem de credenciais inválidas", "email: invalid@test.com, password: admin123", "Média"],
        ["Auth-005: Login With Invalid Password", "Testa login com senha incorreta", "1. Enviar POST /auth/login com senha incorreta\n2. Verificar erro", "Status 401 e mensagem de credenciais inválidas", "email: admin@example.com, password: wrongpass", "Média"],
        ["Auth-006: Register With Invalid Email Format", "Testa registro com formato de email inválido", "1. Enviar POST /auth/register com email mal formatado\n2. Verificar erro", "Status 400 e mensagem de formato inválido", "email: invalid-email, password: 123456", "Baixa"],
        ["Auth-007: Register With Weak Password", "Testa registro com senha fraca", "1. Enviar POST /auth/register com senha fraca\n2. Verificar erro", "Status 400 e mensagem de senha fraca", "password: 123 (muito curta)", "Baixa"]
    ])
    
    # API - Filmes
    test_cases.extend([
        ["Movies-001: Get All Movies Successfully", "Testa listagem de todos os filmes", "1. Enviar GET /movies\n2. Verificar lista retornada", "Status 200 e lista de filmes com dados completos", "Nenhum parâmetro necessário", "Alta"],
        ["Movies-002: Get Movie By Valid ID", "Testa busca de filme por ID válido", "1. Enviar GET /movies/{id} com ID válido\n2. Verificar dados do filme", "Status 200 e dados completos do filme", "movieId: 1 (ID válido)", "Alta"],
        ["Movies-003: Get Movie By Invalid ID", "Testa busca de filme com ID inválido", "1. Enviar GET /movies/{id} com ID inválido\n2. Verificar erro", "Status 404 e mensagem de filme não encontrado", "movieId: 999999 (inexistente)", "Média"],
        ["Movies-004: Get Movie Sessions Successfully", "Testa listagem de sessões do filme", "1. Enviar GET /movies/{id}/sessions\n2. Verificar sessões", "Status 200 e lista de sessões disponíveis", "movieId: 1", "Alta"],
        ["Movies-005: Get Sessions For Invalid Movie", "Testa busca de sessões para filme inexistente", "1. Enviar GET /movies/{id}/sessions com ID inválido\n2. Verificar erro", "Status 404 e mensagem de filme não encontrado", "movieId: 999999", "Baixa"],
        ["Movies-006: Validate Movie Data Structure", "Valida estrutura dos dados do filme", "1. Enviar GET /movies/{id}\n2. Validar campos obrigatórios", "Resposta contém id, title, genre, duration, rating", "movieId: 1", "Média"],
        ["Movies-007: Search Movies By Genre", "Testa busca de filmes por gênero", "1. Enviar GET /movies?genre={genre}\n2. Verificar filtro aplicado", "Status 200 e apenas filmes do gênero especificado", "genre: Action", "Média"],
        ["Movies-008: Get Movie Availability", "Testa verificação de disponibilidade", "1. Enviar GET /movies/{id}/availability\n2. Verificar disponibilidade", "Status 200 e informações de disponibilidade", "movieId: 1", "Média"]
    ])
    
    # API - Reservas
    test_cases.extend([
        ["Reservations-001: Create Reservation Successfully", "Testa criação de reserva com dados válidos", "1. Fazer login para obter token\n2. Enviar POST /reservations com dados válidos\n3. Verificar criação", "Status 201 e reserva criada com ID", "sessionId: 1, seats: [A1, A2], token: válido", "Crítica"],
        ["Reservations-002: Create Reservation Without Authentication", "Testa criação sem autenticação", "1. Enviar POST /reservations sem token\n2. Verificar erro de autenticação", "Status 401 e mensagem de não autorizado", "Sem token de autenticação", "Alta"],
        ["Reservations-003: Create Reservation With Invalid Session", "Testa criação com sessão inválida", "1. Enviar POST /reservations com sessão inexistente\n2. Verificar erro", "Status 404 e mensagem de sessão não encontrada", "sessionId: 999999 (inexistente)", "Média"],
        ["Reservations-004: Create Reservation With Occupied Seats", "Testa criação com assentos ocupados", "1. Enviar POST /reservations com assentos já ocupados\n2. Verificar erro", "Status 409 e mensagem de assentos indisponíveis", "seats: [A1] (já ocupado)", "Alta"],
        ["Reservations-005: Get User Reservations Successfully", "Testa listagem de reservas do usuário", "1. Fazer login\n2. Enviar GET /reservations\n3. Verificar lista", "Status 200 e lista de reservas do usuário", "Token de usuário válido", "Alta"],
        ["Reservations-006: Get Reservation By ID Successfully", "Testa busca de reserva por ID", "1. Enviar GET /reservations/{id} com ID válido\n2. Verificar dados", "Status 200 e dados completos da reserva", "reservationId: 1", "Média"],
        ["Reservations-007: Cancel Reservation Successfully", "Testa cancelamento de reserva", "1. Enviar DELETE /reservations/{id}\n2. Verificar cancelamento", "Status 200 e confirmação de cancelamento", "reservationId: 1 (existente)", "Alta"],
        ["Reservations-008: Cancel Non-Existent Reservation", "Testa cancelamento de reserva inexistente", "1. Enviar DELETE /reservations/{id} com ID inválido\n2. Verificar erro", "Status 404 e mensagem de reserva não encontrada", "reservationId: 999999", "Baixa"],
        ["Reservations-009: Create Reservation With Empty Seats", "Testa criação sem seleção de assentos", "1. Enviar POST /reservations sem assentos\n2. Verificar erro", "Status 400 e mensagem de assentos obrigatórios", "seats: [] (vazio)", "Média"]
    ])
    
    # Web - Login
    test_cases.extend([
        ["Web-Login-001: Login With Valid Credentials", "Testa login com credenciais válidas", "1. Acessar página /login\n2. Preencher email e senha válidos\n3. Clicar em Login\n4. Verificar redirecionamento", "Usuário logado e redirecionado para página inicial", "email: joao@teste.com, password: 123456", "Crítica"],
        ["Web-Login-002: Login With Invalid Email", "Testa login com email inválido", "1. Acessar página /login\n2. Preencher email inválido\n3. Clicar em Login\n4. Verificar erro", "Permanece na página de login", "email: invalid@email.com", "Média"],
        ["Web-Login-003: Login With Invalid Password", "Testa login com senha inválida", "1. Acessar página /login\n2. Preencher senha incorreta\n3. Clicar em Login\n4. Verificar erro", "Permanece na página de login", "email: joao@teste.com, password: wrongpass", "Média"],
        ["Web-Login-004: Login With Empty Fields", "Testa login com campos vazios", "1. Acessar página /login\n2. Deixar campos vazios\n3. Clicar em Login\n4. Verificar validação", "Permanece na página de login", "Campos vazios", "Média"],
        ["Web-Login-005: Login Form Validation", "Testa validação de formato de email", "1. Acessar página /login\n2. Preencher email mal formatado\n3. Clicar em Login\n4. Verificar validação", "Permanece na página de login", "email: invalid-email", "Baixa"]
    ])
    
    # Web - Cadastro
    test_cases.extend([
        ["Web-Register-001: Register With Valid Data", "Testa cadastro com dados válidos", "1. Acessar página /register\n2. Preencher todos os campos válidos\n3. Clicar em Cadastrar\n4. Verificar sucesso", "Usuário cadastrado e mensagem de boas-vindas exibida", "name: João Silva, email: teste001@cinema.com, password: teste123", "Alta"],
        ["Web-Register-002: Register With Empty Fields", "Testa cadastro com campos vazios", "1. Acessar página /register\n2. Deixar campos vazios\n3. Clicar em Cadastrar\n4. Verificar validação", "Permanece na página de cadastro", "Todos os campos vazios", "Média"],
        ["Web-Register-003: Register With Password Mismatch", "Testa cadastro com senhas diferentes", "1. Acessar página /register\n2. Preencher senhas diferentes\n3. Clicar em Cadastrar\n4. Verificar erro", "Permanece na página de cadastro", "password: teste123, confirmPassword: wrongpass", "Média"],
        ["Web-Register-004: Register With Invalid Email Format", "Testa cadastro com email inválido", "1. Acessar página /register\n2. Preencher email mal formatado\n3. Clicar em Cadastrar\n4. Verificar erro", "Permanece na página de cadastro", "email: invalid-email", "Baixa"],
        ["Web-Register-005: Register With Existing Email", "Testa cadastro com email já existente", "1. Acessar página /register\n2. Preencher email existente\n3. Clicar em Cadastrar\n4. Verificar erro", "Permanece na página de cadastro", "email: joao@teste.com (já existe)", "Média"]
    ])
    
    # Web - Filmes
    test_cases.extend([
        ["Web-Movies-001: Load Movies Page Successfully", "Testa carregamento da página de filmes", "1. Acessar página /movies\n2. Aguardar carregamento\n3. Verificar lista de filmes", "Página carregada com lista de filmes visível", "Nenhum dado específico", "Crítica"],
        ["Web-Movies-002: Search Movie By Title", "Testa busca de filme por título", "1. Acessar página /movies\n2. Digitar título no campo de busca\n3. Verificar resultados", "Filmes filtrados conforme busca", "searchTerm: Inception", "Alta"],
        ["Web-Movies-003: Filter Movies By Genre", "Testa filtro de filmes por gênero", "1. Acessar página /movies\n2. Clicar no filtro de gênero\n3. Selecionar gênero\n4. Verificar filtro", "Apenas filmes do gênero selecionado exibidos", "genre: Action", "Média"],
        ["Web-Movies-004: Search Non-Existent Movie", "Testa busca por filme inexistente", "1. Acessar página /movies\n2. Buscar por filme inexistente\n3. Verificar resultado", "Nenhum resultado encontrado", "searchTerm: FilmeInexistente123", "Baixa"],
        ["Web-Movies-005: Click Movie Card", "Testa clique em card de filme", "1. Acessar página /movies\n2. Clicar em um card de filme\n3. Verificar navegação", "Navegação para página de detalhes", "Primeiro filme da lista", "Alta"],
        ["Web-Movies-006: Clear Search Filter", "Testa limpeza de filtro de busca", "1. Fazer uma busca\n2. Limpar campo de busca\n3. Verificar resultado", "Todos os filmes exibidos novamente", "Limpar campo de busca", "Baixa"],
        ["Web-Movies-007: View Movie Details", "Testa visualização de detalhes do filme", "1. Acessar página /movies\n2. Clicar no botão de detalhes\n3. Verificar página de detalhes", "Página de detalhes carregada corretamente", "Primeiro filme disponível", "Alta"]
    ])
    
    # Web - Reservas
    test_cases.extend([
        ["Web-Reservation-001: Navigate To Reservation Page", "Testa navegação para página de reserva", "1. Acessar página /movies\n2. Clicar em detalhes do filme\n3. Clicar no botão de sessão\n4. Verificar página de reserva", "Página de reserva carregada com assentos", "Primeiro filme disponível", "Crítica"],
        ["Web-Reservation-002: Access Reservation With Login", "Testa acesso à reserva com login", "1. Fazer login\n2. Navegar para reserva\n3. Verificar acesso", "Acesso permitido à página de reserva", "Usuário logado", "Alta"],
        ["Web-Reservation-003: Back Link Navigation", "Testa navegação pelo link voltar", "1. Acessar página de reserva\n2. Clicar no link voltar\n3. Verificar navegação", "Retorna para página de detalhes do filme", "Link .back-link", "Média"],
        ["Web-Reservation-004: Multiple Movie Reservations", "Testa navegação para reserva de diferentes filmes", "1. Acessar reserva de um filme\n2. Voltar e acessar outro filme\n3. Verificar funcionamento", "Navegação funciona para múltiplos filmes", "Diferentes filmes", "Baixa"],
        ["Web-Reservation-005: Select Single Seat", "Testa seleção de um assento", "1. Acessar página de reserva\n2. Clicar em assento disponível\n3. Verificar seleção", "Assento marcado como selecionado", "Assento disponível", "Crítica"],
        ["Web-Reservation-006: Select Multiple Seats", "Testa seleção de múltiplos assentos", "1. Acessar página de reserva\n2. Clicar em múltiplos assentos\n3. Verificar seleções", "Múltiplos assentos selecionados", "Vários assentos disponíveis", "Alta"],
        ["Web-Reservation-007: Verify Occupied Seat Not Selectable", "Testa que assento ocupado não é selecionável", "1. Acessar página de reserva\n2. Tentar clicar em assento ocupado\n3. Verificar comportamento", "Assento ocupado não pode ser selecionado", "Assento com status occupied", "Alta"],
        ["Web-Reservation-008: Deselect Seat", "Testa desseleção de assento", "1. Selecionar um assento\n2. Clicar novamente no assento\n3. Verificar desseleção", "Assento desselecionado", "Assento previamente selecionado", "Média"],
        ["Web-Reservation-009: Proceed To Checkout", "Testa prosseguir para checkout", "1. Selecionar assento\n2. Clicar no botão checkout\n3. Verificar navegação", "Navegação para página de checkout", "Assento selecionado", "Alta"]
    ])
    
    # Web - Navegação
    test_cases.extend([
        ["Web-Navigation-001: Home Page Load", "Testa carregamento da página inicial", "1. Acessar URL base da aplicação\n2. Verificar carregamento\n3. Verificar elementos principais", "Página inicial carregada com título e elementos", "URL: http://localhost:3002", "Crítica"],
        ["Web-Navigation-002: Navigate To Movies Page", "Testa navegação para página de filmes", "1. Acessar página inicial\n2. Navegar para /movies\n3. Verificar carregamento", "Página de filmes carregada corretamente", "Link ou navegação direta", "Alta"],
        ["Web-Navigation-003: Navigate To Login Page", "Testa navegação para página de login", "1. Acessar /login\n2. Verificar elementos da página", "Página de login com campos email e senha", "URL: /login", "Alta"],
        ["Web-Navigation-004: Navigate To Register Page", "Testa navegação para página de cadastro", "1. Acessar /register\n2. Verificar elementos da página", "Página de cadastro com todos os campos", "URL: /register", "Alta"],
        ["Web-Navigation-005: Back Button Functionality", "Testa funcionalidade do botão voltar", "1. Navegar entre páginas\n2. Usar botão voltar do navegador\n3. Verificar navegação", "Navegação reversa funciona corretamente", "Histórico do navegador", "Média"],
        ["Web-Navigation-006: Page Not Found (404)", "Testa página não encontrada", "1. Acessar URL inexistente\n2. Verificar tratamento de erro", "Página permanece funcional", "URL: /pagina-inexistente", "Baixa"]
    ])
    
    # Web - Performance
    test_cases.extend([
        ["Web-Performance-001: Home Page Load Time", "Testa tempo de carregamento da página inicial", "1. Acessar página inicial\n2. Medir tempo de carregamento\n3. Verificar se está dentro do limite", "Carregamento em menos de 10 segundos", "Cronômetro de performance", "Média"],
        ["Web-Performance-002: Movies Page Load Performance", "Testa performance de carregamento da lista de filmes", "1. Acessar página /movies\n2. Medir tempo até lista aparecer\n3. Verificar performance", "Lista carregada em menos de 10 segundos", "Página com múltiplos filmes", "Média"],
        ["Web-Performance-003: Search Response Time", "Testa tempo de resposta da busca", "1. Fazer busca por filme\n2. Medir tempo de resposta\n3. Verificar se está aceitável", "Resposta da busca em menos de 5 segundos", "Termo de busca: Inception", "Baixa"],
        ["Web-Performance-004: Multiple Page Navigation", "Testa performance durante navegação entre páginas", "1. Navegar entre múltiplas páginas\n2. Medir tempo total\n3. Verificar fluidez", "Navegação fluida em menos de 15 segundos", "Sequência: home → movies → login", "Baixa"]
    ])
    
    return test_cases

def create_qality_csv():
    """Cria arquivo CSV para QAlity Plus"""
    
    # Cabeçalho do CSV para QAlity Plus
    headers = ["test case name", "descrição", "test step", "expected result", "test data", "priority"]
    
    # Obter casos de teste
    test_cases = extract_test_cases_qality()
    
    # Criar arquivo CSV
    with open('test_cases_qality_plus.csv', 'w', newline='', encoding='utf-8') as csvfile:
        writer = csv.writer(csvfile)
        
        # Escrever cabeçalho
        writer.writerow(headers)
        
        # Escrever casos de teste
        for case in test_cases:
            writer.writerow(case)
    
    print(f"Arquivo CSV para QAlity Plus criado com {len(test_cases)} casos de teste!")
    print("Arquivo: test_cases_qality_plus.csv")
    print("Formato: Compatível com QAlity Plus plugin")
    print("Campos: test case name, descrição, test step, expected result, test data, priority")

if __name__ == "__main__":
    create_qality_csv()