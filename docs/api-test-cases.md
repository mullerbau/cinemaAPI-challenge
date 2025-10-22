# 🔌 Casos de Teste - API Cinema App

## 🎯 **CASOS ESSENCIAIS PARA AUTOMAÇÃO** (25 casos)

---

## 🔐 **AUTENTICAÇÃO** (8 casos)

### **CT-API-001** - Login com credenciais válidas
**Endpoint:** `POST /auth/login`  
**Dados:** `{"email": "user@example.com", "password": "user123"}`  
**Esperado:** Status 200, retorna token JWT e dados do usuário  

### **CT-API-002** - Login com credenciais inválidas
**Endpoint:** `POST /auth/login`  
**Dados:** `{"email": "invalid@test.com", "password": "wrong"}`  
**Esperado:** Status 400/401, mensagem de erro  

### **CT-API-003** - Login com campos obrigatórios vazios
**Endpoint:** `POST /auth/login`  
**Dados:** `{"email": "", "password": ""}`  
**Esperado:** Status 400, erro de validação  

### **CT-API-004** - Registro de usuário válido
**Endpoint:** `POST /auth/register`  
**Dados:** `{"name": "Novo User", "email": "novo@test.com", "password": "123456"}`  
**Esperado:** Status 201, retorna token e dados do usuário  

### **CT-API-005** - Registro com email já existente
**Endpoint:** `POST /auth/register`  
**Dados:** `{"name": "Test", "email": "user@example.com", "password": "123456"}`  
**Esperado:** Status 400, erro "usuário já existe"  

### **CT-API-006** - Obter perfil com token válido
**Endpoint:** `GET /auth/me`  
**Headers:** `Authorization: Bearer {token}`  
**Esperado:** Status 200, dados do usuário logado  

### **CT-API-007** - Obter perfil sem token
**Endpoint:** `GET /auth/me`  
**Headers:** Sem Authorization  
**Esperado:** Status 401, erro de autenticação  

### **CT-API-008** - Obter perfil com token inválido
**Endpoint:** `GET /auth/me`  
**Headers:** `Authorization: Bearer token_invalido`  
**Esperado:** Status 401/403, erro de token inválido  

---

## 🎬 **FILMES** (5 casos)

### **CT-API-009** - Listar todos os filmes
**Endpoint:** `GET /movies`  
**Esperado:** Status 200, array de filmes com estrutura correta  

### **CT-API-010** - Obter filme por ID válido
**Endpoint:** `GET /movies/{id}`  
**Esperado:** Status 200, dados completos do filme  

### **CT-API-011** - Obter filme por ID inexistente
**Endpoint:** `GET /movies/507f1f77bcf86cd799439011`  
**Esperado:** Status 404, erro "filme não encontrado"  

### **CT-API-012** - Validar estrutura dos dados do filme
**Endpoint:** `GET /movies`  
**Validações:** Verificar campos obrigatórios (title, genre, duration, synopsis)  

### **CT-API-013** - Listar filmes quando vazio
**Endpoint:** `GET /movies`  
**Cenário:** Banco sem filmes  
**Esperado:** Status 200, array vazio  

---

## 🎫 **SESSÕES** (6 casos)

### **CT-API-014** - Listar todas as sessões
**Endpoint:** `GET /sessions`  
**Esperado:** Status 200, array de sessões com dados completos  

### **CT-API-015** - Listar sessões por filme
**Endpoint:** `GET /sessions?movieId={id}`  
**Esperado:** Status 200, sessões filtradas por filme  

### **CT-API-016** - Obter sessão por ID válido
**Endpoint:** `GET /sessions/{id}`  
**Esperado:** Status 200, dados da sessão + assentos disponíveis  

### **CT-API-017** - Obter sessão por ID inexistente
**Endpoint:** `GET /sessions/507f1f77bcf86cd799439011`  
**Esperado:** Status 404, erro "sessão não encontrada"  

### **CT-API-018** - Validar disponibilidade de assentos
**Endpoint:** `GET /sessions/{id}`  
**Validações:** Verificar mapa de assentos (disponível/ocupado)  

### **CT-API-019** - Listar sessões futuras
**Endpoint:** `GET /sessions`  
**Validações:** Apenas sessões com data/hora futura  

---

## 🪑 **RESERVAS** (6 casos)

### **CT-API-020** - Criar reserva válida
**Endpoint:** `POST /reservations`  
**Headers:** `Authorization: Bearer {token}`  
**Dados:** `{"sessionId": "id", "seats": ["A1", "A2"]}`  
**Esperado:** Status 201, dados da reserva criada  

### **CT-API-021** - Criar reserva sem autenticação
**Endpoint:** `POST /reservations`  
**Headers:** Sem Authorization  
**Esperado:** Status 401, erro de autenticação  

### **CT-API-022** - Reservar assento já ocupado
**Endpoint:** `POST /reservations`  
**Dados:** Assento já reservado  
**Esperado:** Status 400, erro "assento não disponível"  

### **CT-API-023** - Listar reservas do usuário
**Endpoint:** `GET /reservations`  
**Headers:** `Authorization: Bearer {token}`  
**Esperado:** Status 200, reservas do usuário logado  

### **CT-API-024** - Cancelar reserva própria
**Endpoint:** `DELETE /reservations/{id}`  
**Headers:** `Authorization: Bearer {token}`  
**Esperado:** Status 200, reserva cancelada + assentos liberados  

### **CT-API-025** - Obter detalhes da reserva
**Endpoint:** `GET /reservations/{id}`  
**Headers:** `Authorization: Bearer {token}`  
**Esperado:** Status 200, dados completos da reserva  

---

## 📊 **RESUMO DE COBERTURA**

| Módulo | Casos | Cobertura |
|--------|-------|-----------|
| **Autenticação** | 8 | Login, Registro, Perfil, Segurança |
| **Filmes** | 5 | CRUD básico, Validações |
| **Sessões** | 6 | Listagem, Filtros, Assentos |
| **Reservas** | 6 | CRUD, Autenticação, Regras de negócio |

**TOTAL: 25 casos essenciais**

## 🎯 **CRITÉRIOS DE SELEÇÃO**
- ✅ **Fluxos críticos** do negócio
- ✅ **Cenários de erro** mais comuns
- ✅ **Validações de segurança** essenciais
- ✅ **Estrutura de dados** básica
- ✅ **Regras de negócio** principais

## 🚀 **ORDEM DE IMPLEMENTAÇÃO SUGERIDA**
1. **Autenticação** (CT-API-001 a 008) - Base para outros testes
2. **Filmes** (CT-API-009 a 013) - Dados básicos
3. **Sessões** (CT-API-014 a 019) - Disponibilidade
4. **Reservas** (CT-API-020 a 025) - Fluxo principal