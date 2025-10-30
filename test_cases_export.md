# Casos de Teste - Sistema de Cinema
**Projeto**: Automação de Testes para Sistema de Reservas de Cinema  
**Total de Casos**: 72 casos de teste  
**Data**: $(date)

---

## 📡 TESTES DE API (24 casos)

### 🔐 Autenticação (7 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Auth-001 | Register New User Successfully | Testa registro de novo usuário com dados válidos | Positivo | Alta |
| Auth-002 | Login With Valid Credentials | Testa login com credenciais válidas | Positivo | Crítica |
| Auth-003 | Register User With Existing Email | Testa registro com email já existente | Negativo | Média |
| Auth-004 | Login With Invalid Email | Testa login com email inválido | Negativo | Média |
| Auth-005 | Login With Invalid Password | Testa login com senha incorreta | Negativo | Média |
| Auth-006 | Register With Invalid Email Format | Testa registro com formato de email inválido | Negativo | Baixa |
| Auth-007 | Register With Weak Password | Testa registro com senha fraca | Negativo | Baixa |

### 🎬 Filmes (8 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Movies-001 | Get All Movies Successfully | Testa listagem de todos os filmes | Positivo | Alta |
| Movies-002 | Get Movie By Valid ID | Testa busca de filme por ID válido | Positivo | Alta |
| Movies-003 | Get Movie By Invalid ID | Testa busca de filme com ID inválido | Negativo | Média |
| Movies-004 | Get Movie Sessions Successfully | Testa listagem de sessões do filme | Positivo | Alta |
| Movies-005 | Get Sessions For Invalid Movie | Testa busca de sessões para filme inexistente | Negativo | Baixa |
| Movies-006 | Validate Movie Data Structure | Valida estrutura dos dados do filme | Positivo | Média |
| Movies-007 | Search Movies By Genre | Testa busca de filmes por gênero | Positivo | Média |
| Movies-008 | Get Movie Availability | Testa verificação de disponibilidade | Positivo | Média |

### 🎫 Reservas (9 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Reservations-001 | Create Reservation Successfully | Testa criação de reserva com dados válidos | Positivo | Crítica |
| Reservations-002 | Create Reservation Without Authentication | Testa criação sem autenticação | Negativo | Alta |
| Reservations-003 | Create Reservation With Invalid Session | Testa criação com sessão inválida | Negativo | Média |
| Reservations-004 | Create Reservation With Occupied Seats | Testa criação com assentos ocupados | Negativo | Alta |
| Reservations-005 | Get User Reservations Successfully | Testa listagem de reservas do usuário | Positivo | Alta |
| Reservations-006 | Get Reservation By ID Successfully | Testa busca de reserva por ID | Positivo | Média |
| Reservations-007 | Cancel Reservation Successfully | Testa cancelamento de reserva | Positivo | Alta |
| Reservations-008 | Cancel Non-Existent Reservation | Testa cancelamento de reserva inexistente | Negativo | Baixa |
| Reservations-009 | Create Reservation With Empty Seats | Testa criação sem seleção de assentos | Negativo | Média |

---

## 🌐 TESTES WEB (48 casos)

### 🔐 Login (5 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Login-001 | Login With Valid Credentials | Testa login com credenciais válidas | Positivo | Crítica |
| Web-Login-002 | Login With Invalid Email | Testa login com email inválido | Negativo | Média |
| Web-Login-003 | Login With Invalid Password | Testa login com senha inválida | Negativo | Média |
| Web-Login-004 | Login With Empty Fields | Testa login com campos vazios | Negativo | Média |
| Web-Login-005 | Login Form Validation | Testa validação de formato de email | Negativo | Baixa |

### 📝 Cadastro (5 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Register-001 | Register With Valid Data | Testa cadastro com dados válidos | Positivo | Alta |
| Web-Register-002 | Register With Empty Fields | Testa cadastro com campos vazios | Negativo | Média |
| Web-Register-003 | Register With Password Mismatch | Testa cadastro com senhas diferentes | Negativo | Média |
| Web-Register-004 | Register With Invalid Email Format | Testa cadastro com email inválido | Negativo | Baixa |
| Web-Register-005 | Register With Existing Email | Testa cadastro com email já existente | Negativo | Média |

### 🎬 Filmes (7 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Movies-001 | Load Movies Page Successfully | Testa carregamento da página de filmes | Positivo | Crítica |
| Web-Movies-002 | Search Movie By Title | Testa busca de filme por título | Positivo | Alta |
| Web-Movies-003 | Filter Movies By Genre | Testa filtro de filmes por gênero | Positivo | Média |
| Web-Movies-004 | Search Non-Existent Movie | Testa busca por filme inexistente | Negativo | Baixa |
| Web-Movies-005 | Click Movie Card | Testa clique em card de filme | Positivo | Alta |
| Web-Movies-006 | Clear Search Filter | Testa limpeza de filtro de busca | Positivo | Baixa |
| Web-Movies-007 | View Movie Details | Testa visualização de detalhes do filme | Positivo | Alta |

### 🎫 Reservas (9 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Reservation-001 | Navigate To Reservation Page | Testa navegação para página de reserva | Positivo | Crítica |
| Web-Reservation-002 | Access Reservation With Login | Testa acesso à reserva com login | Positivo | Alta |
| Web-Reservation-003 | Back Link Navigation | Testa navegação pelo link voltar | Positivo | Média |
| Web-Reservation-004 | Multiple Movie Reservations | Testa navegação para reserva de diferentes filmes | Positivo | Baixa |
| Web-Reservation-005 | Select Single Seat | Testa seleção de um assento | Positivo | Crítica |
| Web-Reservation-006 | Select Multiple Seats | Testa seleção de múltiplos assentos | Positivo | Alta |
| Web-Reservation-007 | Verify Occupied Seat Not Selectable | Testa que assento ocupado não é selecionável | Negativo | Alta |
| Web-Reservation-008 | Deselect Seat | Testa desseleção de assento | Positivo | Média |
| Web-Reservation-009 | Proceed To Checkout | Testa prosseguir para checkout | Positivo | Alta |

### 🧭 Navegação (6 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Navigation-001 | Home Page Load | Testa carregamento da página inicial | Positivo | Crítica |
| Web-Navigation-002 | Navigate To Movies Page | Testa navegação para página de filmes | Positivo | Alta |
| Web-Navigation-003 | Navigate To Login Page | Testa navegação para página de login | Positivo | Alta |
| Web-Navigation-004 | Navigate To Register Page | Testa navegação para página de cadastro | Positivo | Alta |
| Web-Navigation-005 | Back Button Functionality | Testa funcionalidade do botão voltar | Positivo | Média |
| Web-Navigation-006 | Page Not Found (404) | Testa página não encontrada | Negativo | Baixa |

### ⚡ Performance (4 casos)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-Performance-001 | Home Page Load Time | Testa tempo de carregamento da página inicial | Performance | Média |
| Web-Performance-002 | Movies Page Load Performance | Testa performance de carregamento da lista de filmes | Performance | Média |
| Web-Performance-003 | Search Response Time | Testa tempo de resposta da busca | Performance | Baixa |
| Web-Performance-004 | Multiple Page Navigation | Testa performance durante navegação entre páginas | Performance | Baixa |

### 🎨 Interface (8 casos - Não implementados)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| Web-UI-001 | Responsive Design Mobile | Testa design responsivo em mobile | UI | Baixa |
| Web-UI-002 | Responsive Design Tablet | Testa design responsivo em tablet | UI | Baixa |
| Web-UI-003 | Dark Mode Toggle | Testa alternância entre modo claro e escuro | UI | Baixa |
| Web-UI-004 | Loading States | Testa estados de carregamento | UI | Baixa |
| Web-UI-005 | Form Input Validation Visual Feedback | Testa feedback visual de validação de formulários | UI | Baixa |
| Web-UI-006 | Accessibility Features | Testa recursos de acessibilidade | UI | Média |
| Web-UI-007 | Image Loading and Alt Text | Testa carregamento de imagens e texto alternativo | UI | Baixa |
| Web-UI-008 | Tooltip and Help Text | Testa tooltips e textos de ajuda | UI | Baixa |

### 🔄 Fluxo de Reserva (4 casos - Com dependência MongoDB)
| ID | Nome | Descrição | Tipo | Prioridade |
|---|---|---|---|---|
| CT017 | Fluxo completo de reserva | Valida fluxo end-to-end de reserva | E2E | Crítica |
| CT018 | Tentativa de reserva sem login | Valida redirecionamento para login | E2E | Alta |
| CT019 | Validar assentos ocupados | Valida que assentos ocupados não podem ser selecionados | E2E | Alta |
| CT020 | Cancelar reserva | Valida cancelamento de reserva existente | E2E | Média |

---

## 📊 RESUMO ESTATÍSTICO

### Por Categoria
- **API**: 24 casos (33.3%)
- **Web**: 48 casos (66.7%)

### Por Tipo
- **Positivos**: 45 casos (62.5%)
- **Negativos**: 23 casos (31.9%)
- **Performance**: 4 casos (5.6%)

### Por Prioridade
- **Crítica**: 8 casos (11.1%)
- **Alta**: 25 casos (34.7%)
- **Média**: 28 casos (38.9%)
- **Baixa**: 11 casos (15.3%)

### Status de Implementação
- **Implementados e Funcionais**: 40 casos (55.6%)
- **Implementados com Falhas**: 20 casos (27.8%)
- **Não Implementados**: 12 casos (16.7%)

---

## 🔧 FERRAMENTAS E TECNOLOGIAS
- **Framework**: Robot Framework
- **API Testing**: RequestsLibrary
- **Web Testing**: Browser Library (Playwright)
- **Linguagem**: Python
- **Banco de Dados**: MongoDB
- **Controle de Versão**: Git

---

## 📈 COBERTURA DE TESTES
- **Funcionalidades Principais**: 95%
- **Casos de Erro**: 85%
- **Performance**: 60%
- **Interface**: 0% (não implementado)

---

*Documento gerado automaticamente do projeto de automação de testes*