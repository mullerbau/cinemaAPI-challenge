# 🤖 Prompt para Evolução do Plano de Testes

## Prompt para IA

```
Você é um especialista em automação de testes com foco em aplicações web e APIs. 

Analise o seguinte contexto detalhado:

## APLICAÇÃO: Sistema de Cinema com Reserva de Assentos

### ARQUITETURA TÉCNICA:
- **Backend:** Node.js + Express + MongoDB Atlas
- **Frontend:** React + Vite (porta 5173)
- **API:** REST endpoints em /api/v1
- **Autenticação:** JWT Bearer tokens
- **Banco:** MongoDB com collections: users, movies, sessions, reservations, theaters
- **Documentação:** Swagger UI disponível

### ESTRUTURA DO BANCO DE DADOS:
- **Users:** name, email, password (bcrypt), role (user/admin)
- **Movies:** title, synopsis, director, genres[], duration, classification, poster, releaseDate
- **Sessions:** movie_id, theater_id, datetime, fullPrice, halfPrice, seats[{row, number, status}]
- **Reservations:** user_id, session_id, seats[{row, number, type}], totalPrice, status, paymentStatus
- **Theaters:** name, capacity, layout

### ENDPOINTS PRINCIPAIS:
- **Auth:** POST /auth/login, POST /auth/register, GET /auth/me, PUT /auth/profile
- **Movies:** GET /movies, GET /movies/:id
- **Sessions:** GET /sessions, GET /sessions/:id, GET /sessions?movieId=X
- **Reservations:** GET /reservations, POST /reservations, DELETE /reservations/:id
- **Setup:** POST /setup/admin, POST /setup/test-users (dev only)

### FRAMEWORK DE TESTE:
- **Robot Framework** com RequestsLibrary (API) e Browser Library (Web)
- **Data Management:** Python com PyMongo para limpeza de massa de dados
- **Keywords customizadas** para setup/teardown de dados
- **Estrutura:** 25 casos API + 20 casos Web = 45 casos essenciais

### FUNCIONALIDADES IMPLEMENTADAS:
- Sistema completo de autenticação com roles
- CRUD de filmes com validações
- Sessões com mapa de assentos dinâmico
- Reservas com validação de disponibilidade
- Interface responsiva com navegação
- Fluxo completo: Login → Filme → Sessão → Assentos → Reserva

### REGRAS DE NEGÓCIO IDENTIFICADAS:
- Assentos podem ser: available, reserved, occupied
- Tipos de ingresso: full, half (meia-entrada)
- Usuários só veem suas próprias reservas
- Sessões futuras vs passadas
- Validação de conflitos de horário
- Preços dinâmicos por sessão

### CENÁRIOS JÁ COBERTOS:
- Autenticação (login válido/inválido, perfil, tokens)
- CRUD básico de filmes e sessões
- Reservas simples (criar, listar, cancelar)
- Navegação web básica
- Validações de segurança (401, 403, 404)

Com base neste contexto detalhado, me ajude a:

1. **Identificar cenários críticos** que podem estar faltando no meu plano atual
2. **Sugerir casos de teste edge cases** específicos para cinema (ex: sessão esgotada, reserva simultânea)
3. **Propor testes de integração** entre API e frontend que validem consistência
4. **Recomendar validações de segurança** específicas para JWT e roles
5. **Indicar métricas de qualidade** e KPIs para acompanhar
6. **Sugerir cenários de concorrência** para reservas simultâneas
7. **Propor validações de dados** específicas do domínio cinema

Considere especialmente:
- Reservas simultâneas no mesmo assento (race conditions)
- Validações de horários de sessão (conflitos, passado/futuro)
- Comportamento quando sessão está esgotada
- Integridade referencial (filme deletado com sessões ativas)
- Validações de preço e cálculos
- Cenários de falha de pagamento
- Limites de reservas por usuário
- Expiração de reservas não confirmadas

Forneça sugestões práticas e implementáveis com Robot Framework, considerando que tenho controle total do MongoDB para setup de dados.
```

## Informações Adicionais para Contexto:

### AMBIENTE DE TESTE:
- **API Base URL:** http://localhost:3000/api/v1
- **Web Base URL:** http://localhost:5173
- **Swagger Docs:** http://localhost:3000/api/v1/docs
- **MongoDB:** Atlas Cloud (controle total para limpeza)

### DADOS DE TESTE PADRÃO:
- **Usuário Válido:** user@example.com / user123
- **Admin:** admin@example.com / admin123
- **Usuários de Teste:** Padrão test@*.com
- **Filmes:** Dados seedados via scripts

### ESTRUTURA DO PROJETO:
```
challenge_final-uol/
├── docs/           # Documentação e planos
├── tests/api/      # 25 casos essenciais API
├── tests/web/      # 20 casos essenciais Web
├── keywords/       # Keywords customizadas
├── utils/          # Data management Python
└── variables/      # Configurações globais
```

### GAPS CONHECIDOS PARA EVOLUÇÃO:
- Testes de concorrência (reservas simultâneas)
- Validações de integridade referencial
- Cenários de expiração de sessão
- Testes de performance com alta carga
- Validações de cálculo de preços
- Cenários de recuperação de falhas

### FERRAMENTAS DISPONÍVEIS:
- **Robot Framework** com libraries modernas
- **Python Data Manager** com keywords para MongoDB
- **Browser Library** para testes web modernos
- **RequestsLibrary** para testes de API
- **Controle total** do banco para setup/teardown