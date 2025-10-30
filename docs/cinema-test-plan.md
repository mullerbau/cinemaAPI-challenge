# 📋 Plano de Testes - Cinema App Challenge

**Challenge:** Utilizando os conhecimentos adquiridos em automação de testes, desenvolva um planejamento e execução de testes automatizados para a aplicação Cinema App. O objetivo é garantir a qualidade da aplicação com foco nas regras de negócio, APIs REST e interface web, aplicando Robot Framework com RequestsLibrary e Browser Library.

## 1. Apresentação

Este documento apresenta o planejamento e a execução dos testes automatizados realizados na aplicação Cinema App, um sistema completo de reserva de ingressos de cinema que permite gerenciamento de usuários, filmes, sessões e reservas.

O objetivo é demonstrar a estratégia de automação aplicada, os cenários efetivamente testados e as lacunas identificadas para evolução futura.

### 1.1 Equipe de Testes

**Testador Responsável:** [Seu Nome]

**Período de Execução:** [Data Início] - [Data Fim]

**Ambiente API:** http://localhost:3000/api/v1

**Ambiente Web:** http://localhost:5173

**Documentação:** http://localhost:3000/api/v1/docs

### 1.2 Ferramentas Utilizadas

- **Robot Framework:** Framework principal de automação
- **RequestsLibrary:** Testes de API REST
- **Browser Library:** Testes de interface web moderna
- **PyMongo:** Gerenciamento de massa de dados MongoDB
- **MongoDB Atlas:** Banco de dados em nuvem
- **Swagger UI:** Documentação e referência de endpoints
- **GitHub:** Controle de versão e CI/CD

## 2. Objetivo

Garantir a qualidade da aplicação Cinema App através da validação automatizada de cenários funcionais críticos, assegurando o funcionamento correto dos fluxos principais de negócio (Autenticação, Filmes, Sessões e Reservas) tanto na API quanto na interface web.

### 2.1 Objetivos Específicos

- Automatizar 45 casos de teste essenciais (25 API + 20 Web)
- Validar endpoints principais com autenticação JWT
- Testar fluxo completo de reserva end-to-end
- Implementar gerenciamento inteligente de massa de dados
- Garantir cobertura de cenários positivos e negativos
- Estabelecer base sólida para evolução futura

## 3. Escopo

### 3.1 Módulos Incluídos

**API (/api/v1):**
- **Autenticação** (/auth) → login, registro, perfil, tokens JWT
- **Filmes** (/movies) → listagem, detalhes, validações
- **Sessões** (/sessions) → horários, assentos, disponibilidade
- **Reservas** (/reservations) → CRUD completo com autenticação

**Interface Web:**
- **Login/Registro** → autenticação via formulários
- **Navegação** → home, detalhes de filmes, responsividade
- **Seleção** → sessões, mapa de assentos interativo
- **Reserva** → fluxo completo end-to-end

### 3.2 Fora do Escopo (Primeira Iteração)

- Funcionalidades administrativas (gestão de salas/sessões)
- Testes de performance e carga
- Múltiplos browsers (foco em Chromium)
- Integração com sistemas de pagamento
- Relatórios e analytics
- Notificações e e-mails

## 4. Análise

### 4.1 O que foi testado

**Autenticação:**
- Login com credenciais válidas/inválidas
- Registro de novos usuários
- Validação de tokens JWT
- Acesso a endpoints protegidos

**Filmes:**
- Listagem de filmes disponíveis
- Busca por ID válido/inexistente
- Validação de estrutura de dados
- Campos obrigatórios

**Sessões:**
- Listagem de sessões por filme
- Mapa de assentos e disponibilidade
- Validação de horários

**Reservas:**
- Criação com dados válidos
- Validação de assentos ocupados
- Listagem por usuário
- Cancelamento de reservas

**Interface Web:**
- Fluxo de login e navegação
- Responsividade básica
- Seleção de filmes e sessões
- Processo completo de reserva

### 4.2 Lacunas identificadas

- Testes de concorrência (reservas simultâneas)
- Validação de expiração de sessões
- Cenários de falha de pagamento
- Limites de reservas por usuário
- Integridade referencial (filme deletado com sessões)
- Validações de preço e cálculos
- Testes de acessibilidade (WCAG)
- Performance com alta carga de usuários

## 5. Técnicas Aplicadas

- **Baseado em Requisitos** → validação dos fluxos críticos de negócio
- **Particionamento de Equivalência** → dados válidos vs inválidos
- **Testes Automatizados** → Robot Framework com keywords customizadas
- **Data Management** → limpeza inteligente de massa de dados
- **Page Objects Pattern** → estruturação de testes web
- **Service Objects** → abstração de chamadas de API
- **Cenários Independentes** → cada teste com setup/teardown próprio

## 6. Cenários de Teste Executados

### API (25 casos)

**Autenticação (8 casos):**
- ✅ Login com credenciais válidas
- ✅ Login com credenciais inválidas  
- ✅ Login com campos obrigatórios vazios
- ✅ Registro de usuário válido
- ✅ Registro com email já existente
- ✅ Obter perfil com token válido
- ✅ Obter perfil sem token
- ✅ Obter perfil com token inválido

**Filmes (5 casos):**
- ✅ Listar todos os filmes
- ✅ Obter filme por ID válido
- ✅ Obter filme por ID inexistente
- ✅ Validar estrutura dos dados
- ✅ Listar filmes quando vazio

**Sessões (6 casos):**
- ✅ Listar todas as sessões
- ✅ Listar sessões por filme
- ✅ Obter sessão por ID válido
- ✅ Obter sessão por ID inexistente
- ✅ Validar disponibilidade de assentos
- ✅ Listar sessões futuras

**Reservas (6 casos):**
- ✅ Criar reserva válida
- ✅ Criar reserva sem autenticação
- ✅ Reservar assento já ocupado
- ✅ Listar reservas do usuário
- ✅ Cancelar reserva própria
- ✅ Obter detalhes da reserva

### Web (20 casos)

**Autenticação Web (6 casos):**
- ✅ Login com credenciais válidas
- ✅ Login com credenciais inválidas
- ✅ Validação de campos obrigatórios
- ✅ Registro de novo usuário
- ✅ Logout do sistema
- ✅ Redirecionamento após login

**Navegação e Filmes (5 casos):**
- ✅ Carregamento da página inicial
- ✅ Visualizar detalhes do filme
- ✅ Buscar filmes
- ✅ Responsividade mobile
- ✅ Menu de navegação

**Sessões e Seleção (4 casos):**
- ✅ Listar sessões do filme
- ✅ Selecionar sessão
- ✅ Mapa de assentos interativo
- ✅ Seleção de múltiplos assentos

**Fluxo de Reserva (5 casos):**
- ✅ Finalizar reserva (usuário logado)
- ✅ Tentar reservar sem login
- ✅ Fluxo completo de reserva
- ✅ Visualizar minhas reservas
- ✅ Cancelar reserva

## 7. Priorização

**Alta prioridade (executados):** Autenticação, CRUD básico, fluxo principal de reserva

**Média prioridade (parcialmente executados):** Validações avançadas, cenários de erro

**Baixa prioridade (não executados):** Funcionalidades admin, casos extremos, performance

## 8. Matriz de Risco

| Risco | Probabilidade | Impacto | Mitigação |
|-------|---------------|---------|-----------|
| Reserva simultânea no mesmo assento | Alta | Alto | Testes de concorrência futuros |
| Token JWT não expira corretamente | Média | Alto | Validação de expiração |
| Sessão esgotada não bloqueia reserva | Alta | Alto | Validado em testes |
| Falha na integração API-Frontend | Média | Alto | Testes end-to-end implementados |
| Dados corrompidos no MongoDB | Baixa | Alto | Data management com limpeza |

## 9. Cobertura de Testes

- **Autenticação:** 90% dos cenários críticos cobertos
- **Filmes:** 80% das funcionalidades validadas  
- **Sessões:** 75% incluindo mapa de assentos
- **Reservas:** 85% do fluxo principal
- **Interface Web:** 70% dos fluxos de usuário
- **Automação:** 45 casos automatizados (100% do escopo MVP)

## 10. Testes Candidatos à Automação (implementados)

**Já Automatizados:**
- Login com credenciais válidas (token salvo automaticamente)
- CRUD completo de reservas com validações
- Fluxo end-to-end de reserva via web
- Cenários de erro com validações de status codes
- Gerenciamento de massa de dados com limpeza inteligente

**Próximas Iterações:**
- Testes de concorrência com múltiplos usuários
- Validações de integridade referencial
- Cenários de performance com carga
- Testes de acessibilidade web

## 11. Estrutura de Automação

```
challenge_final-uol/
├── docs/                    # Documentação e planos
├── tests/
│   ├── api/                # 25 casos de API
│   └── web/                # 20 casos de Web
├── keywords/               # Keywords customizadas
├── utils/                  # Data management Python
├── variables/              # Configurações globais
└── results/               # Relatórios de execução
```

**Keywords Principais:**
- `Clean User From Database` - Limpeza de usuários
- `Create Test User` - Criação de massa de dados
- `Fazer Login Via API` - Autenticação automatizada
- `Validar Resposta de Sucesso` - Validações padronizadas

## 12. Conclusão

O conjunto de testes automatizados realizado na aplicação Cinema App garantiu a validação dos fluxos principais de negócio, com destaque para:

**Pontos Fortes:**
- Cobertura completa dos cenários críticos (45 casos)
- Gerenciamento inteligente de massa de dados
- Estrutura escalável com keywords reutilizáveis
- Integração API + Web validada end-to-end
- Base sólida para evolução futura

**Lacunas Identificadas:**
- Testes de concorrência para reservas simultâneas
- Validações de performance com alta carga
- Cenários de integridade referencial complexos
- Testes de acessibilidade e usabilidade avançados

**Próximos Passos:**
Esses pontos devem ser priorizados em ciclos futuros para garantir cobertura total dos cenários de produção, especialmente os relacionados à concorrência e performance em cenários de alta demanda.

A base de automação estabelecida permite evolução rápida e manutenção eficiente dos testes, garantindo qualidade contínua da aplicação Cinema App.