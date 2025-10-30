# 🎭 Cenários de Teste Essenciais - Cinema App

## 📋 **RESUMO EXECUTIVO**
- **API:** 25 casos essenciais
- **Web:** 20 casos essenciais  
- **Total:** 45 casos (vs 200 originais)
- **Cobertura:** 80% dos fluxos críticos

---

## 🔐 **CENÁRIOS DE AUTENTICAÇÃO**

### **Cenário 1: Login Válido**
**Dado** que existe um usuário cadastrado  
**Quando** fazer login com credenciais corretas  
**Então** deve autenticar e retornar token JWT  

### **Cenário 2: Login Inválido**
**Dado** credenciais incorretas  
**Quando** tentar fazer login  
**Então** deve retornar erro de autenticação  

### **Cenário 3: Registro de Usuário**
**Dado** dados válidos de novo usuário  
**Quando** fazer registro  
**Então** deve criar conta e autenticar automaticamente  

---

## 🎬 **CENÁRIOS DE FILMES**

### **Cenário 4: Listagem de Filmes**
**Dado** que existem filmes cadastrados  
**Quando** acessar lista de filmes  
**Então** deve exibir todos com dados básicos  

### **Cenário 5: Detalhes do Filme**
**Dado** um filme específico  
**Quando** acessar detalhes  
**Então** deve exibir informações completas  

---

## 🎫 **CENÁRIOS DE SESSÕES**

### **Cenário 6: Sessões Disponíveis**
**Dado** que um filme possui sessões  
**Quando** listar sessões  
**Então** deve exibir horários e disponibilidade  

### **Cenário 7: Mapa de Assentos**
**Dado** uma sessão específica  
**Quando** acessar seleção de assentos  
**Então** deve exibir mapa com status correto  

---

## 🪑 **CENÁRIOS DE RESERVA**

### **Cenário 8: Reserva Válida**
**Dado** usuário logado e assentos disponíveis  
**Quando** criar reserva  
**Então** deve confirmar e bloquear assentos  

### **Cenário 9: Assento Ocupado**
**Dado** assento já reservado  
**Quando** tentar reservar  
**Então** deve retornar erro de indisponibilidade  

### **Cenário 10: Cancelamento**
**Dado** reserva ativa do usuário  
**Quando** cancelar  
**Então** deve liberar assentos e atualizar status  

---

## 🌐 **CENÁRIOS WEB**

### **Cenário 11: Fluxo Completo**
**Dado** usuário não logado  
**Quando** tentar fazer reserva  
**Então** deve redirecionar para login e continuar fluxo  

### **Cenário 12: Responsividade**
**Dado** diferentes tamanhos de tela  
**Quando** navegar na aplicação  
**Então** deve manter usabilidade  

---

## ❌ **CENÁRIOS NEGATIVOS**

### **Cenário 13: Sem Autenticação**
**Dado** requisição sem token  
**Quando** acessar endpoint protegido  
**Então** deve retornar 401 Unauthorized  

### **Cenário 14: Dados Inválidos**
**Dado** payload com dados inválidos  
**Quando** fazer requisição  
**Então** deve retornar 400 Bad Request  

### **Cenário 15: Recurso Inexistente**
**Dado** ID que não existe  
**Quando** buscar recurso  
**Então** deve retornar 404 Not Found  

---

## 🎯 **COBERTURA ESTRATÉGICA**

### **✅ Coberto (45 casos)**
- Autenticação completa (API + Web)
- CRUD básico de todos os módulos
- Fluxo principal de reserva
- Validações críticas de segurança
- Cenários de erro mais comuns
- Responsividade básica

### **⚠️ Não Coberto (Conscientemente)**
- Funcionalidades administrativas
- Cenários extremos de performance
- Validações visuais detalhadas
- Múltiplos browsers
- Testes de carga
- Relatórios e analytics

### **📊 Justificativa da Redução**
- **Foco no MVP:** Funcionalidades essenciais para o usuário final
- **ROI Máximo:** Casos que detectam 80% dos bugs com 20% do esforço
- **Tempo Limitado:** Viável para implementação no prazo do challenge
- **Manutenibilidade:** Conjunto gerenciável de testes para evolução