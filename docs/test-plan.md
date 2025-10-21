# 📋 Plano de Testes - Cinema App

## 🎯 Objetivo
Validar as funcionalidades principais da aplicação de cinema através de testes automatizados de API e interface web.

## 🔍 Escopo dos Testes

### API Tests
- **Autenticação**
  - Login de usuário
  - Registro de usuário
  - Validação de token JWT

- **Filmes**
  - Listar filmes
  - Buscar filme por ID
  - Validar dados do filme

- **Sessões**
  - Listar sessões disponíveis
  - Buscar sessões por filme
  - Validar horários e salas

- **Reservas**
  - Criar reserva
  - Listar reservas do usuário
  - Cancelar reserva
  - Validar assentos disponíveis

### Web Tests
- **Fluxo de Login**
  - Login com credenciais válidas
  - Login com credenciais inválidas
  - Logout

- **Navegação**
  - Listar filmes na home
  - Acessar detalhes do filme
  - Navegar entre páginas

- **Fluxo de Reserva**
  - Selecionar filme
  - Escolher sessão
  - Selecionar assentos
  - Finalizar reserva

## 🏷️ Critérios de Aceitação
- Todos os endpoints da API devem responder corretamente
- Interface web deve ser responsiva e funcional
- Fluxos críticos devem funcionar end-to-end
- Validações de segurança devem estar implementadas

## 🚫 Fora do Escopo
- Testes de performance
- Testes de segurança avançados
- Testes de compatibilidade com múltiplos browsers

## 📊 Métricas de Cobertura
- Cobertura de endpoints: 100%
- Cobertura de fluxos críticos: 100%
- Cobertura de cenários negativos: 80%