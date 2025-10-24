# 🚀 Comandos para Execução dos Testes - Cinema App

## 📋 **Comandos Básicos**

### **Executar TODOS os testes**
```bash
robot tests/
```

### **Executar apenas testes de API**
```bash
robot tests/api/
# OU usando tags
robot --include api tests/
```

### **Executar apenas testes Web**
```bash
robot tests/web/
# OU usando tags
robot --include web tests/
```

## 🎯 **Execução por Tags**

### **Testes Críticos (Smoke Tests)**
```bash
robot --include smoke tests/
robot --include critical tests/
```

### **Por Tipo de Teste**
```bash
# Apenas testes positivos
robot --include positive tests/

# Apenas testes negativos  
robot --include negative tests/

# Testes de segurança
robot --include security tests/

# Testes de validação
robot --include validation tests/
```

### **Por Tipo de Interface**
```bash
# Apenas testes de API
robot --include api tests/

# Apenas testes Web
robot --include web tests/

# Combinação: API de autenticação
robot --include apiANDauth tests/

# Combinação: Web de reservas
robot --include webANDreservations tests/
```

### **Por Módulo**
```bash
# Autenticação (API + Web)
robot --include auth tests/

# Filmes (API + Web)
robot --include movies tests/

# Reservas (API + Web)
robot --include reservations tests/
```

### **Por Funcionalidade**
```bash
# Endpoints públicos
robot --include public tests/

# Endpoints protegidos
robot --include protected tests/

# Operações CRUD
robot --include crud tests/

# Regras de negócio
robot --include business_rule tests/
```

## 📊 **Execução com Relatórios Customizados**

### **Relatório em diretório específico**
```bash
robot -d results/smoke --include smoke tests/
robot -d results/api tests/api/
robot -d results/web tests/web/
```

### **Relatório com nome customizado**
```bash
robot -d results --report api_report.html --log api_log.html tests/api/
```

### **Execução silenciosa (apenas erros)**
```bash
robot --loglevel ERROR tests/
```

### **Execução verbosa (debug)**
```bash
robot --loglevel DEBUG tests/
```

## 🔍 **Execução de Testes Específicos**

### **Por arquivo específico**
```bash
robot tests/api/auth_tests.robot
robot tests/api/movies_tests.robot
robot tests/api/reservations_tests.robot
```

### **Por test case específico**
```bash
robot -t "CT-API-001*" tests/api/auth_tests.robot
robot -t "*Login com credenciais válidas*" tests/
```

### **Múltiplas tags combinadas**
```bash
# Testes críticos de API
robot --include apiANDcritical tests/

# Testes críticos de Web
robot --include webANDcritical tests/

# Smoke tests apenas de API
robot --include apiANDsmoke tests/

# Testes de segurança (API + Web)
robot --include security tests/

# Testes negativos de API
robot --include apiANDnegative tests/

# Testes de validação Web
robot --include webANDvalidation tests/

# Excluir testes específicos
robot --exclude edge_case tests/
```

## ⚡ **Execução Paralela (se necessário)**

### **Executar módulos em paralelo**
```bash
# Terminal 1
robot --include auth tests/

# Terminal 2  
robot --include movies tests/

# Terminal 3
robot --include reservations tests/
```

## 🛠️ **Comandos de Setup e Limpeza**

### **Preparar ambiente antes dos testes**
```bash
# Instalar dependências
pip install -r requirements.txt

# Configurar dados básicos
python -c "from utils.data_manager import setup_basic_test_data; setup_basic_test_data()"
```

### **Limpeza após testes**
```bash
python -c "from utils.data_manager import clean_all_test_data; clean_all_test_data()"
```

## 📈 **Execução com Métricas**

### **Estatísticas detalhadas**
```bash
robot --listener allure_robotframework tests/
robot --xunit xunit.xml tests/
```

### **Execução com timeout**
```bash
robot --timeout 30s tests/
```

### **Execução com retry em falhas**
```bash
robot --rerunfailed output.xml tests/
```

## 🎪 **Cenários de Uso Comuns**

### **Desenvolvimento (testes rápidos)**
```bash
robot --include smoke tests/
```

### **CI/CD Pipeline**
```bash
robot --include critical --exclude edge_case -d results tests/
```

### **Regressão completa**
```bash
robot --include positive --include negative -d results/regression tests/
```

### **Testes de segurança**
```bash
robot --include security --include unauthorized -d results/security tests/
```

### **Validação de release**
```bash
robot --include critical --include business_critical -d results/release tests/
```

## 📋 **Tags Disponíveis**

| Tag | Descrição | Exemplo |
|-----|-----------|---------|
| `api` | Testes de API REST | `robot --include api tests/` |
| `web` | Testes de interface web | `robot --include web tests/` |
| `smoke` | Testes básicos essenciais | `robot --include smoke tests/` |
| `critical` | Testes críticos do negócio | `robot --include critical tests/` |
| `positive` | Cenários de sucesso | `robot --include positive tests/` |
| `negative` | Cenários de erro | `robot --include negative tests/` |
| `security` | Testes de segurança | `robot --include security tests/` |
| `validation` | Testes de validação | `robot --include validation tests/` |
| `public` | Endpoints públicos | `robot --include public tests/` |
| `protected` | Endpoints protegidos | `robot --include protected tests/` |
| `crud` | Operações CRUD | `robot --include crud tests/` |
| `business_rule` | Regras de negócio | `robot --include business_rule tests/` |
| `jwt` | Testes relacionados a JWT | `robot --include jwt tests/` |
| `unauthorized` | Testes de não autorização | `robot --include unauthorized tests/` |
| `edge_case` | Casos extremos | `robot --include edge_case tests/` |
| `e2e` | Testes end-to-end | `robot --include e2e tests/` |
| `ui` | Testes de interface | `robot --include ui tests/` |
| `responsive` | Testes de responsividade | `robot --include responsive tests/` |

## 🎯 **Comandos Recomendados por Fase**

### **Desenvolvimento Local**
```bash
# Smoke tests de API (mais rápido)
robot --include apiANDsmoke tests/

# Smoke tests completos (API + Web)
robot --include smoke tests/
```

### **Teste de Integração**
```bash
# Testes críticos de API
robot --include apiANDcritical tests/

# Testes críticos completos
robot --include critical tests/
```

### **Teste de Regressão**
```bash
# Regressão completa
robot tests/

# Regressão apenas API
robot --include api tests/

# Regressão apenas Web
robot --include web tests/
```

### **Validação de Deploy**
```bash
# Validação rápida (API)
robot --include apiANDsmoke tests/

# Validação completa
robot --include smoke --include critical tests/
```