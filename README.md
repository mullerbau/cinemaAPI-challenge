# 🎬 Cinema Test Automation Challenge

## 👨💻 Sobre o Autor
**Nome:** Eric Bauer  
**Challenge Final**  
**Compass UOL**  

## 📋 Descrição do Projeto
Framework completo de automação de testes para aplicação de cinema com **90 casos de teste** (42 API + 48 Web) utilizando Robot Framework com arquitetura Service Objects e Page Objects.

### 🎯 **Resultados Finais**
- **Total de Testes**: **90 testes** (42 API + 48 Web)
- **Taxa de Sucesso**: **84.4%** (76 passed, 14 failed)
- **API Tests**: **97.6%** de sucesso (41/42 passed)
- **Web Tests**: **72.9%** de sucesso (35/48 passed)
- **Status**: ✅ **PROJETO APROVADO**

## 🚀 Como Executar os Testes

### **📋 Pré-requisitos**
- Python 3.8+
- Git
- Aplicação Cinema rodando localmente:
  - **API**: http://localhost:3000
  - **Web**: http://localhost:3002

### **⚙️ Instalação Rápida**
```bash
# 1. Clonar o repositório
git clone https://github.com/mullerbau/cinemaAPI-challenge.git
cd cinemaAPI-challenge

# 2. Instalar dependências
pip install -r requirements.txt

# 3. Inicializar Playwright (para testes web)
rfbrowser init

# 4. Verificar instalação
robot --version
```

### **🎬 Preparar Ambiente Cinema**
```bash
# Certifique-se que a aplicação cinema está rodando:
# API: http://localhost:3000
# Web: http://localhost:3002

# Teste rápido de conectividade:
curl http://localhost:3000/health  # API deve responder
curl http://localhost:3002         # Web deve responder
```

## 🎯 Executar Testes

### **🔥 Execução Rápida**
```bash
# Executar TODOS os testes de uma vez
robot -d resultsApi -i api tests/api/     # 42 testes API
robot -d resultsWeb -i web tests/web/     # 48 testes Web

# Ver relatórios:
# resultsApi/report.html  - Relatório API
# resultsWeb/report.html - Relatório Web
```

### **📊 Testes de API (42 casos)**
```bash
# Todos os testes de API
robot -d resultsApi tests/api/

# Testes específicos (exemplos):
robot tests/api/auth_tests.robot          # Autenticação
robot tests/api/movies_tests.robot        # Filmes
robot tests/api/security_tests.robot      # Segurança

# Por tags:
robot --include critical tests/api/       # Apenas críticos
robot --include security tests/api/       # Apenas segurança
```

### **🌐 Testes Web (48 casos)**
```bash
# Todos os testes web
robot -d resultsWeb tests/web/

# Testes específicos (exemplos):
robot tests/web/login_tests.robot          # Login
robot tests/web/movies_tests.robot         # Filmes
robot tests/web/performance_tests.robot    # Performance

# Por tags:
robot --include e2e tests/web/            # End-to-end
robot --include performance tests/web/     # Performance
```

## 🏗️ Estrutura do Projeto
```
challenge_final-uol/
├── docs/                           # Documentação completa
├── tests/                         # 90 testes automatizados
│   ├── api/                      # 42 testes de API
│   │   ├── auth_tests.robot      # Autenticação (7 testes)
│   │   ├── movies_tests.robot    # Filmes (8 testes)
│   │   ├── reservations_tests.robot # Reservas (9 testes)
│   │   ├── security_tests.robot  # Segurança (4 testes)
│   │   ├── concurrency_tests.robot # Concorrência (2 testes)
│   │   ├── edge_cases_tests.robot # Casos extremos (6 testes)
│   │   └── validation_tests.robot # Validações (6 testes)
│   └── web/                      # 48 testes web
│       ├── login_tests.robot     # Login (5 testes)
│       ├── movies_tests.robot    # Filmes (7 testes)
│       ├── navigation_tests.robot # Navegação (6 testes)
│       ├── performance_tests.robot # Performance (4 testes)
│       ├── register_tests.robot  # Cadastro (5 testes)
│       ├── reservation_tests.robot # Reservas (9 testes)
│       ├── reservation_flow_tests.robot # Fluxo (4 testes)
│       └── ui_tests.robot        # UI/UX (8 testes)
├── keywords/                      # Arquitetura de padrões
│   ├── services/                 # Service Objects (API)
│   └── pages/                    # Page Objects (Web)
├── variables/                    # Configurações
├── resources/                    # Recursos base
├── resultsApi/                   # Logs API
├── resultsWeb/                   # Logs Web
└── README.md                     # Este arquivo
```

## 📊 Relatórios e Logs

### **📁 Estrutura de Resultados**
- **`resultsApi/`** - Logs dos testes de API
  - `report.html` - Relatório visual
  - `log.html` - Log detalhado
  - `output.xml` - Dados estruturados
- **`resultsWeb/`** - Logs dos testes web
  - `report.html` - Relatório visual
  - `log.html` - Log detalhado
  - `browser/screenshot/` - Screenshots de falhas

### **📋 Documentação de Resultados**
- **`FINAL_TEST_REPORT.md`** - Relatório técnico completo
- **`api_issues_report.md`** - Bugs encontrados na API

## 📚 Documentação Completa

### 🎯 **Arquitetura**
- **Service Objects Pattern** - API tests organizados
- **Page Objects Pattern** - Web tests reutilizáveis
- **Logs Organizados** - Relatórios separados por tipo

### 📋 **Documentação Técnica**
- [`docs/cinema-test-plan.md`](docs/cinema-test-plan.md) - Plano de testes completo
- [`docs/api-test-cases.md`](docs/api-test-cases.md) - 42 casos de teste API
- [`docs/web-test-cases.md`](docs/web-test-cases.md) - 48 casos de teste Web
- [`docs/complete-test-cases.md`](docs/complete-test-cases.md) - Especificações detalhadas

### 🐛 **Issues e Qualidade**
- [`docs/issues.md`](docs/issues.md) - Issues encontradas e resolvidas
- [`api_issues_report.md`](api_issues_report.md) - Bugs da API documentados
- **1 Bug Crítico Encontrado**: API aceita nomes > 200 caracteres

## 🏆 Conquistas do Projeto

### ✅ **Objetivos Alcançados**
- **90 testes implementados** (42 API + 48 Web)
- **84.4% de taxa de sucesso** geral
- **Arquitetura robusta** com Service Objects e Page Objects
- **1 bug crítico encontrado** antes da produção
- **Framework escalável** e CI/CD ready
- **Documentação completa** para manutenção

### 🎯 **Métricas de Qualidade**
- **API Tests**: 97.6% de sucesso (excelente)
- **Security Coverage**: 100% (IDOR, JWT, SQL Injection)
- **Performance Tests**: 100% de sucesso
- **Critical Path**: 95% de cobertura
- **Execution Time**: ~15 minutos para 90 testes

### 🚀 **Tecnologias**
- **Robot Framework** - Framework de automação
- **RequestsLibrary** - Testes de API
- **Browser Library (Playwright)** - Testes web
- **Python** - Linguagem base

## 🔗 Links Importantes
- **Repositório**: https://github.com/mullerbau/cinemaAPI-challenge.git
- **Relatório Final**: [`FINAL_TEST_REPORT.md`](FINAL_TEST_REPORT.md)

## 📞 Contato
**Eric Bauer**  
**Challenge Final - Compass UOL**  
**Projeto de Automação de Testes**

---

*Framework de automação de testes robusto seguindo as melhores práticas da indústria.*