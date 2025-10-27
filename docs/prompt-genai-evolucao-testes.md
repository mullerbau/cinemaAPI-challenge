# 🤖 Prompt GenAI - Evolução do Plano de Testes Cinema App

## 🎯 **Objetivo do Prompt**
Este prompt foi desenvolvido para auxiliar na evolução, melhoria e ajuste contínuo do plano de testes da aplicação Cinema App, aplicando conhecimentos de planejamento de testes, análise de riscos e estratégias de automação.

---

## 📋 **PROMPT PARA INTELIGÊNCIA ARTIFICIAL**

```
Você é um especialista em Quality Assurance e Test Automation com 10+ anos de experiência em testes de APIs REST e aplicações web. Sua missão é analisar e evoluir o plano de testes de uma aplicação de cinema.

## CONTEXTO DA APLICAÇÃO:
- **Sistema**: Cinema App - Reserva de ingressos online
- **Backend**: API REST (Node.js + MongoDB) com 33 endpoints
- **Frontend**: React SPA com fluxos de usuário
- **Arquitetura**: Microserviços com autenticação JWT
- **Módulos**: Auth, Movies, Sessions, Theaters, Reservations, Users

## SITUAÇÃO ATUAL DOS TESTES:
- ✅ API Tests: 24/24 casos (100% cobertura)
- 🔄 Web Tests: 0/20 casos (em desenvolvimento)
- 🏗️ Framework: Robot Framework + Service Objects
- 📊 Cobertura: Auth (7), Movies (8), Reservations (9)

## ENDPOINTS PRINCIPAIS:
**Authentication**: POST /auth/register, POST /auth/login, GET /auth/me
**Movies**: GET /movies, GET /movies/{id}, POST /movies (admin)
**Reservations**: POST /reservations, GET /reservations/me, DELETE /reservations/{id}
**Sessions**: GET /sessions, POST /sessions (admin), GET /sessions/{id}

## ISSUES IDENTIFICADAS:
1. Conflitos de dados de teste (resolvido)
2. Endpoints não implementados (contornado)
3. Inconsistência em status codes HTTP
4. Estrutura de resposta variável

## SUA TAREFA:
Analise o plano atual e forneça recomendações específicas para:

### 1. EVOLUÇÃO DOS TESTES API
- Cenários de teste adicionais não cobertos
- Testes de integração entre módulos
- Validações de performance e carga
- Testes de segurança avançados
- Cenários de edge cases e boundary values

### 2. ESTRATÉGIA PARA TESTES WEB
- Casos de teste prioritários para implementar
- Fluxos E2E críticos do usuário
- Testes de usabilidade automatizáveis
- Validações de responsividade
- Testes de acessibilidade

### 3. MELHORIA DA ARQUITETURA
- Padrões de design adicionais
- Otimizações no framework atual
- Estratégias de data management
- Paralelização de testes
- Integração com CI/CD

### 4. ANÁLISE DE RISCOS
- Áreas de maior risco não cobertas
- Cenários de falha críticos
- Dependências externas a testar
- Testes de recuperação de falhas

### 5. MÉTRICAS E MONITORAMENTO
- KPIs de qualidade a implementar
- Relatórios avançados
- Alertas automáticos
- Dashboards de acompanhamento

## FORMATO DA RESPOSTA:
Organize sua resposta em seções claras com:
- **Prioridade** (Alta/Média/Baixa)
- **Esforço** (Baixo/Médio/Alto)
- **Impacto** (Baixo/Médio/Alto)
- **Implementação** (passos específicos)
- **Ferramentas** (se aplicável)

## RESTRIÇÕES:
- Manter Robot Framework como base
- Considerar recursos limitados de tempo
- Focar em ROI dos testes
- Priorizar automação sobre testes manuais
- Considerar manutenibilidade a longo prazo

Forneça recomendações práticas e implementáveis que elevem a qualidade e cobertura dos testes, considerando as melhores práticas da indústria e tendências atuais em test automation.
```

---

## 🎯 **Como Usar Este Prompt**

### **1. Copie o Prompt Completo**
- Selecione todo o conteúdo da seção "PROMPT PARA INTELIGÊNCIA ARTIFICIAL"
- Cole em qualquer ferramenta de IA (ChatGPT, Claude, Gemini, etc.)

### **2. Contextualize Conforme Necessário**
- Atualize números de testes se houver mudanças
- Adicione novos endpoints descobertos
- Inclua issues específicas encontradas

### **3. Refine as Respostas**
- Faça perguntas de follow-up específicas
- Peça exemplos de implementação
- Solicite priorização de recomendações

---

## 📊 **Exemplos de Uso**

### **Pergunta de Follow-up 1:**
```
"Das recomendações fornecidas, quais 3 você implementaria primeiro considerando que tenho apenas 2 dias disponíveis?"
```

### **Pergunta de Follow-up 2:**
```
"Como implementar testes de performance para a API de reservas usando Robot Framework? Forneça exemplo de código."
```

### **Pergunta de Follow-up 3:**
```
"Quais cenários de teste E2E são mais críticos para o fluxo de reserva de ingressos?"
```

---

## 🔄 **Evolução Contínua**

### **Atualize o Prompt Quando:**
- Novos módulos forem adicionados à aplicação
- Issues críticas forem descobertas
- Cobertura de testes mudar significativamente
- Novas tecnologias forem integradas

### **Mantenha Histórico:**
- Salve as respostas da IA em arquivos datados
- Compare recomendações ao longo do tempo
- Implemente melhorias sugeridas gradualmente

---

## 🎯 **Benefícios Esperados**

### **Curto Prazo:**
- Identificação de gaps na cobertura atual
- Priorização de testes mais importantes
- Otimização do framework existente

### **Médio Prazo:**
- Implementação de testes E2E robustos
- Melhoria na detecção de bugs
- Redução de regressões em produção

### **Longo Prazo:**
- Framework de testes escalável
- Cultura de qualidade estabelecida
- ROI positivo da automação

---

## 📝 **Observações Técnicas**

- **Versão do Prompt**: 1.0
- **Data de Criação**: Dezembro 2024
- **Compatibilidade**: ChatGPT 4+, Claude 3+, Gemini Pro
- **Contexto Máximo**: ~2000 tokens
- **Resposta Esperada**: ~1500-2000 tokens

**Este prompt foi desenvolvido aplicando técnicas de prompt engineering e conhecimentos específicos de test automation para maximizar a qualidade das recomendações geradas pela IA.**