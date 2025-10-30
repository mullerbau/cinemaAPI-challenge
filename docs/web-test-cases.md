# 🌐 Casos de Teste - Interface Web Cinema App

## 🎯 **CASOS ESSENCIAIS PARA AUTOMAÇÃO** (20 casos)

---

## 🔐 **AUTENTICAÇÃO WEB** (6 casos)

### **CT-WEB-001** - Login com credenciais válidas
**Página:** `/login`  
**Passos:**
1. Preencher email: "user@example.com"
2. Preencher senha: "user123"  
3. Clicar em "Entrar"
**Esperado:** Redirecionamento para home, usuário logado

### **CT-WEB-002** - Login com credenciais inválidas
**Página:** `/login`  
**Passos:**
1. Preencher email: "invalid@test.com"
2. Preencher senha: "wrong"
3. Clicar em "Entrar"
**Esperado:** Mensagem de erro, permanece na tela de login

### **CT-WEB-003** - Validação de campos obrigatórios
**Página:** `/login`  
**Passos:**
1. Deixar campos vazios
2. Clicar em "Entrar"
**Esperado:** Mensagens de validação nos campos

### **CT-WEB-004** - Registro de novo usuário
**Página:** `/register`  
**Passos:**
1. Preencher nome: "Novo Usuário"
2. Preencher email único
3. Preencher senha: "123456"
4. Clicar em "Registrar"
**Esperado:** Conta criada, usuário logado automaticamente

### **CT-WEB-005** - Logout do sistema
**Pré-condição:** Usuário logado  
**Passos:**
1. Clicar no botão "Sair"
**Esperado:** Logout realizado, redirecionamento para login

### **CT-WEB-006** - Redirecionamento após login
**Página:** Qualquer página protegida sem estar logado  
**Passos:**
1. Tentar acessar página protegida
2. Fazer login
**Esperado:** Redirecionamento para página original

---

## 🎬 **NAVEGAÇÃO E FILMES** (5 casos)

### **CT-WEB-007** - Carregamento da página inicial
**Página:** `/`  
**Esperado:** 
- Lista de filmes carregada
- Layout responsivo
- Menu de navegação funcional

### **CT-WEB-008** - Visualizar detalhes do filme
**Página:** `/`  
**Passos:**
1. Clicar em um filme da lista
**Esperado:** 
- Página de detalhes carregada
- Informações completas (sinopse, duração, gênero)
- Botão "Ver Sessões" visível

### **CT-WEB-009** - Buscar filmes
**Página:** `/movies`  
**Passos:**
1. Digitar nome do filme na busca
2. Pressionar Enter ou clicar em buscar
**Esperado:** Resultados filtrados conforme busca

### **CT-WEB-010** - Responsividade mobile
**Página:** Qualquer página  
**Passos:**
1. Redimensionar browser para mobile (375px)
**Esperado:** Layout adaptado, elementos acessíveis

### **CT-WEB-011** - Menu de navegação
**Página:** Qualquer página  
**Passos:**
1. Clicar em cada item do menu
**Esperado:** Navegação funcional entre páginas

---

## 🎫 **SESSÕES E SELEÇÃO** (4 casos)

### **CT-WEB-012** - Listar sessões do filme
**Página:** `/movies/{id}`  
**Passos:**
1. Clicar em "Ver Sessões"
**Esperado:** 
- Lista de sessões disponíveis
- Horários e salas visíveis
- Botões de seleção ativos

### **CT-WEB-013** - Selecionar sessão
**Página:** Página de sessões  
**Passos:**
1. Clicar em uma sessão disponível
**Esperado:** Redirecionamento para seleção de assentos

### **CT-WEB-014** - Mapa de assentos interativo
**Página:** `/seat-selection`  
**Esperado:**
- Mapa de assentos carregado
- Assentos disponíveis/ocupados diferenciados
- Seleção múltipla funcional

### **CT-WEB-015** - Seleção de múltiplos assentos
**Página:** `/seat-selection`  
**Passos:**
1. Clicar em 2-3 assentos disponíveis
**Esperado:** 
- Assentos marcados como selecionados
- Contador de assentos atualizado
- Preço total calculado

---

## 🪑 **FLUXO DE RESERVA** (5 casos)

### **CT-WEB-016** - Finalizar reserva (usuário logado)
**Pré-condição:** Usuário logado, assentos selecionados  
**Passos:**
1. Clicar em "Confirmar Reserva"
**Esperado:** 
- Reserva criada com sucesso
- Mensagem de confirmação
- Redirecionamento para "Minhas Reservas"

### **CT-WEB-017** - Tentar reservar sem login
**Pré-condição:** Usuário não logado  
**Passos:**
1. Selecionar assentos
2. Tentar finalizar reserva
**Esperado:** Redirecionamento para login

### **CT-WEB-018** - Fluxo completo de reserva
**Passos:**
1. Fazer login
2. Selecionar filme
3. Escolher sessão
4. Selecionar assentos
5. Confirmar reserva
**Esperado:** Reserva criada end-to-end

### **CT-WEB-019** - Visualizar minhas reservas
**Pré-condição:** Usuário logado com reservas  
**Página:** `/my-reservations`  
**Esperado:**
- Lista de reservas do usuário
- Detalhes de cada reserva
- Opção de cancelamento

### **CT-WEB-020** - Cancelar reserva
**Página:** `/my-reservations`  
**Passos:**
1. Clicar em "Cancelar" em uma reserva
2. Confirmar cancelamento
**Esperado:**
- Reserva cancelada
- Assentos liberados
- Lista atualizada

---

## 📊 **RESUMO DE COBERTURA**

| Módulo | Casos | Cobertura |
|--------|-------|-----------|
| **Autenticação Web** | 6 | Login, Registro, Logout, Validações |
| **Navegação e Filmes** | 5 | Home, Detalhes, Busca, Responsividade |
| **Sessões e Seleção** | 4 | Listagem, Seleção, Mapa de assentos |
| **Fluxo de Reserva** | 5 | Reserva completa, Cancelamento |

**TOTAL: 20 casos essenciais**

## 🎯 **CRITÉRIOS DE SELEÇÃO**
- ✅ **Fluxos principais** do usuário
- ✅ **Jornada completa** de reserva
- ✅ **Validações críticas** de UX
- ✅ **Responsividade** básica
- ✅ **Cenários de erro** comuns

## 🚀 **ORDEM DE IMPLEMENTAÇÃO SUGERIDA**
1. **Autenticação** (CT-WEB-001 a 006) - Acesso ao sistema
2. **Navegação** (CT-WEB-007 a 011) - Funcionalidades básicas  
3. **Sessões** (CT-WEB-012 a 015) - Seleção de assentos
4. **Reserva** (CT-WEB-016 a 020) - Fluxo principal

## 🔄 **INTEGRAÇÃO COM API**
Estes testes web validam a integração com os endpoints da API, garantindo que:
- Autenticação funciona end-to-end
- Dados são exibidos corretamente
- Ações do usuário refletem no backend
- Fluxos críticos funcionam completamente

## 📱 **CONSIDERAÇÕES TÉCNICAS**
- **Browser:** Chromium (Browser Library)
- **Responsividade:** Teste em 375px (mobile) e 1920px (desktop)
- **Timeouts:** 10s para elementos críticos
- **Seletores:** Preferir text-based e CSS modernos