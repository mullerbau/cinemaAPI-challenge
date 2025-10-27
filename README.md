# 🎬 Cinema App - Automação de Testes

## 👨‍💻 Sobre o Autor
**Nome:** Eric Bauer  
**Challenge Final**  
**Compass UOL**  

Projeto de automação de testes para sistema de reservas de cinema, desenvolvido como challenge final aplicando conhecimentos de testes automatizados, padrões de design e boas práticas de desenvolvimento.

---

## 🎯 **Sobre o Projeto**

### **Aplicação Testada**
- **Backend**: API REST Cinema App (Node.js + MongoDB)
- **Frontend**: Interface Web Cinema App (React)
- **Arquitetura**: Microserviços com autenticação JWT

### **Objetivo**
Desenvolver framework completo de testes automatizados cobrindo:
- ✅ **API Testing**: 24 casos de teste (100% cobertura)
- 🔄 **Web Testing**: 20 casos de teste (em desenvolvimento)
- 🔧 **Data Management**: Limpeza e setup automático
- 📊 **Reporting**: Relatórios detalhados e métricas

---

## 🏗️ **Arquitetura do Projeto**

```
challenge_final-uol/
├── 📁 tests/
│   ├── api/                    # Testes de API (24 casos)
│   └── web/                    # Testes Web (20 casos)
├── 📁 keywords/
│   ├── services/               # Service Objects (Auth, Movies, Reservations)
│   └── helpers/                # Keywords auxiliares
├── 📁 libs/                    # Scripts Python
│   ├── mongodb_cleanup.py      # Limpeza de dados
│   └── setup_test_data.py      # Setup de dados de teste
├── 📁 resources/
│   └── base.robot              # Configurações centralizadas
├── 📁 variables/
│   └── config.robot            # Variáveis e URLs
├── 📁 docs/                    # Documentação
│   ├── issues-encontradas.md   # Issues e bugs documentados
│   └── api-test-cases.md       # Casos de teste detalhados
└── 📄 requirements.txt         # Dependências Python
```

---

## 🚀 **Pré-requisitos**

### **Software Necessário**
- **Python 3.12+** (recomendado)
- **Node.js 18+** (para executar a aplicação)
- **MongoDB** (local ou Docker)
- **Git** (para versionamento)

### **Aplicações**
- **Cinema Backend**: `http://localhost:3000`
- **Cinema Frontend**: `http://localhost:5173`
- **MongoDB**: `mongodb://localhost:27017`

---

## ⚙️ **Configuração do Ambiente**

### **1. Clone o Repositório**
```bash
# Clonar o repositório
git clone https://github.com/mullerbau/cinemaAPI-challenge

### **2. Instale as Dependências Python**
```bash
# Para Python 3.12
py -3.12 -m pip install -r requirements.txt

# Ou usando pip padrão
pip install -r requirements.txt
```

### **3. Configure as Aplicações**
```bash
# Inicie o MongoDB (se local)
mongod

# Inicie o Backend Cinema
cd ../cinema-challenge-back
npm install
npm start

# Inicie o Frontend Cinema (nova aba)
cd ../cinema-challenge-front  
npm install
npm run dev
```

### **4. Setup dos Dados de Teste**
```bash
# Cria dados básicos (admin, teatros, sessões)
python libs/setup_test_data.py
```

---

## 🧪 **Execução dos Testes**

### **Todos os Testes API**
```bash
robot tests/api/
```

### **Por Módulo**
```bash
# Testes de Autenticação
robot tests/api/auth_tests.robot

# Testes de Filmes  
robot tests/api/movies_tests.robot

# Testes de Reservas
robot tests/api/reservations_tests.robot
```

### **Por Tags**
```bash
# Apenas testes críticos
robot --include critical tests/api/

# Apenas testes de smoke
robot --include smoke tests/api/

# Testes positivos
robot --include positive tests/api/

# Testes negativos  
robot --include negative tests/api/
```

### **Testes Web (Em Desenvolvimento)**
```bash
robot tests/web/
```

---

## 📊 **Resultados e Relatórios**

### **Arquivos Gerados**
- `output.xml` - Dados estruturados dos testes
- `log.html` - Log detalhado da execução
- `report.html` - Relatório visual dos resultados

### **Métricas Atuais**
- ✅ **API Tests**: 24/24 (100%)
- 🔄 **Web Tests**: 0/20 (0% - em desenvolvimento)
- 📈 **Cobertura Total**: 55% (24/44 casos planejados)

---

## 🎨 **Padrões e Boas Práticas**

### **Service Objects Pattern**
```robot
# Exemplo: keywords/services/auth_service.robot
Login User
    [Arguments]    ${email}    ${password}
    ${response}=    POST On Session    cinema_api    /auth/login
    RETURN    ${response}
```

### **Data Management**
```python
# Limpeza automática antes dos testes
def cleanup_test_data():
    client = get_database_connection()
    db = client["cinema_app"]
    db.users.delete_many({"email": {"$in": test_emails}})
```

### **Validações Flexíveis**
```robot
# Aceita múltiplos status codes válidos
Should Be True    ${response.status_code} in [200, 201]
```

---

## 🏷️ **Sistema de Tags**

| Tag | Descrição | Uso |
|-----|-----------|-----|
| `api` | Testes de API | Separar API de Web |
| `web` | Testes Web | Separar Web de API |
| `positive` | Cenários positivos | Fluxos de sucesso |
| `negative` | Cenários negativos | Validações de erro |
| `smoke` | Testes essenciais | Execução rápida |
| `critical` | Funcionalidades críticas | Testes prioritários |
| `security` | Testes de segurança | Validações de auth |

---

## 🐛 **Issues Conhecidas**

Consulte `docs/issues-encontradas.md` para lista completa de issues identificadas e suas soluções.

### **Principais Issues Resolvidas**
- ✅ Conflito de usuários duplicados
- ✅ Endpoints não implementados  
- ✅ Inconsistência em status codes
- ✅ Estrutura de resposta variável

---

## 🔄 **Branches e Versionamento**

### **Estratégia de Branches**
```
main (produção)
├── testes-api (base dos testes API)
├── testes-web (testes front-end)  
└── feature/api-tests-finalization (desenvolvimento)
```

### **Commits Frequentes**
- Commits atômicos por funcionalidade
- Mensagens descritivas seguindo padrão
- Tags para releases importantes

---

## 🚀 **Inovações Implementadas**

### **1. GenAI Integration**
- Prompts para evolução do plano de testes
- Documentação automatizada de issues

### **2. Data Management Inteligente**
- Cleanup automático do MongoDB
- Geração de dados únicos por timestamp
- Setup automatizado de ambiente

### **3. Validações Adaptativas**
- Testes flexíveis para diferentes cenários
- Suporte a múltiplos status codes
- Fallbacks para endpoints não implementados

---

## 📚 **Documentação Adicional**

- 📋 [Casos de Teste API](docs/api-test-cases.md)
- 🐛 [Issues Encontradas](docs/issues-encontradas.md)  
- 🗺️ [Mapa Mental da API](docs/mindmap-api.md)
- ⚡ [Comandos de Execução](COMANDOS_EXECUCAO.md)

---

## 🤝 **Contribuições**

Este projeto foi desenvolvido individualmente como challenge final, aplicando conhecimentos adquiridos durante a trilha de automação de testes.

### **Agradecimentos**
- Instrutores da trilha de automação
- Comunidade Robot Framework
- Documentação oficial das ferramentas utilizadas

---

## 📄 **Licença**

Projeto educacional desenvolvido para fins de aprendizado e avaliação.

---

## 📞 **Contato**

- **GitHub**: [seu-usuario]
- **LinkedIn**: [seu-perfil]
- **Email**: [seu-email]

---

**🎯 Status do Projeto**: ✅ Testes API Finalizados | 🔄 Testes Web em Desenvolvimento