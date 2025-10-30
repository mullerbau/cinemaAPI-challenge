# 🎬 Cinema Test Automation Challenge

## 👨‍💻 Sobre o Autor
**Nome:** Eric Bauer  
**Challenge Final**  
**Compass UOL**  

## 📋 Descrição do Projeto
Projeto de automação de testes para aplicação de cinema desenvolvido como challenge final do curso de automação de testes. O projeto abrange **42 casos de teste de API** e testes de interface web utilizando Robot Framework com padrões Service Objects.

### 📈 **Métricas Atuais**
- ✅ **API Tests**: 42/42 casos implementados (100%)
- 🔒 **Security Tests**: 4 casos (IDOR, JWT, Injection)
- ⚡ **Edge Cases**: 6 casos (Limites e valores extremos)
- 🔄 **Concurrency**: 2 casos (Race conditions)
- ✅ **Validation**: 6 casos (Formatos e caracteres especiais)
- ✅ **Web Tests**: 35/35 casos implementados (100%)
- 🎨 **UI/UX Tests**: 8 casos (Responsividade, Acessibilidade)
- ⚡ **Performance Tests**: 4 casos (Tempos de resposta)
- 🧩 **Page Objects**: 3 páginas (Login, Movies, Reservations)

## 🏗️ Estrutura do Projeto
```
challenge_final-uol/
├── docs/                    # Documentação e análises
│   ├── test-plan.md        # Plano de testes
│   ├── mind-map.png        # Mapa mental
│   └── test-scenarios.md   # Cenários de teste
├── tests/                  # Testes automatizados
│   ├── api/               # Testes de API
│   ├── web/               # Testes de interface web
│   └── resources/         # Recursos compartilhados
├── keywords/              # Keywords customizadas
├── variables/             # Variáveis globais
├── results/              # Relatórios de execução
└── README.md            # Este arquivo
```

## 🚀 Pré-requisitos
- Python 3.8+
- Robot Framework
- SeleniumLibrary
- RequestsLibrary
- Chrome/Firefox WebDriver

## ⚙️ Instalação
```bash
# Clonar o repositório
git clone https://github.com/mullerbau/cinemaAPI-challenge

# Instalar dependências
pip install -r requirements.txt
```

## 🎯 Execução dos Testes

### **Testes de API (42 casos)**
```bash
# Todos os testes de API
robot tests/api/

# Por módulo específico
robot tests/api/auth_tests.robot          # Autenticação (7 casos)
robot tests/api/movies_tests.robot        # Filmes (8 casos)
robot tests/api/reservations_tests.robot  # Reservas (9 casos)
robot tests/api/security_tests.robot      # Segurança (4 casos)
robot tests/api/edge_cases_tests.robot    # Casos extremos (6 casos)
robot tests/api/concurrency_tests.robot   # Concorrência (2 casos)
robot tests/api/validation_tests.robot    # Validações (6 casos)

# Por tags
robot --include critical tests/api/       # Apenas críticos
robot --include security tests/api/       # Apenas segurança
robot --include smoke tests/api/          # Smoke tests
```

### **Testes Web (35 casos)**
```bash
# Todos os testes web
robot tests/web/

# Por módulo específico
robot tests/web/login_tests.robot          # Login (5 casos)
robot tests/web/movies_tests.robot         # Filmes (7 casos)
robot tests/web/reservation_tests.robot    # Reservas (7 casos)
robot tests/web/navigation_tests.robot     # Navegação (6 casos)
robot tests/web/ui_tests.robot            # Interface (8 casos)
robot tests/web/performance_tests.robot    # Performance (4 casos)

# Por tags
robot --include e2e tests/web/            # End-to-end
robot --include responsive tests/web/      # Responsividade
robot --include accessibility tests/web/   # Acessibilidade
```

## 📊 Relatórios
Os relatórios são gerados automaticamente na pasta `results/` após cada execução.

## 📚 **Documentação Completa**

### 📋 **Testes de API (42 casos)**
- [Documentação Completa dos Testes](docs/api-tests-documentation.md) - Visão geral dos 42 casos
- [Matriz de Casos de Teste](docs/test-cases-matrix.md) - Especificações técnicas detalhadas

### 🌐 **Testes Web (35 casos)**
- [Documentação Completa Web](docs/web-tests-documentation.md) - Visão geral dos 35 casos
- **Page Objects**: Login, Movies, Reservations
- **Cobertura**: E2E, Responsividade, Acessibilidade, Performance

### 🐛 **Issues e Melhorias**
- [Issues Encontradas](docs/issues-encontradas.md) - 8 issues documentadas e resolvidas

### 🤖 **Inovação GenAI**
- [Prompt GenAI](docs/prompt-genai-evolucao-testes.md) - Evolução contínua dos testes

## 🤝 Colaboradores
- [Mencionar colegas que ajudaram]

## 📝 Notas Adicionais
Este projeto foi desenvolvido seguindo as melhores práticas de automação de testes e padrões como Page Objects e Service Objects.