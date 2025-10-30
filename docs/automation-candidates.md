# 🤖 Candidatos à Automação - Cinema App

## 📊 ANÁLISE DE COBERTURA

### 🎯 **CRITÉRIOS PARA AUTOMAÇÃO**
- ✅ **Regressão:** Testes executados frequentemente
- ✅ **Estabilidade:** Funcionalidades maduras e estáveis  
- ✅ **ROI:** Alto retorno sobre investimento
- ✅ **Criticidade:** Impacto alto se falhar
- ✅ **Repetitividade:** Cenários repetitivos
- ❌ **Exploratórios:** Testes que requerem análise humana
- ❌ **Visuais:** Validações de layout/design
- ❌ **Usabilidade:** Experiência do usuário

---

## 🔴 **PRIORIDADE MÁXIMA** (Automação Obrigatória)

### 🔐 **Autenticação API** - 8 casos
- **CT011** - Login com credenciais válidas ⭐
- **CT012** - Login com email inexistente ⭐
- **CT013** - Login com senha incorreta ⭐
- **CT001** - Registro com dados válidos ⭐
- **CT002** - Registro com email já existente ⭐
- **CT021** - Obter perfil com token válido ⭐
- **CT022** - Obter perfil sem token ⭐
- **CT023** - Obter perfil com token inválido ⭐

### 🎬 **Filmes API** - 6 casos
- **CT031** - Listar todos os filmes disponíveis ⭐
- **CT041** - Obter filme por ID válido ⭐
- **CT042** - Obter filme por ID inexistente ⭐
- **CT043** - Validar estrutura dos dados ⭐
- **CT044** - Validar campos obrigatórios ⭐
- **CT032** - Listar filmes vazios ⭐

### 🎫 **Sessões API** - 8 casos
- **CT061** - Listar todas as sessões ⭐
- **CT062** - Listar sessões por filme ⭐
- **CT071** - Obter sessão por ID válido ⭐
- **CT072** - Obter sessão por ID inexistente ⭐
- **CT076** - Obter assentos disponíveis ⭐
- **CT077** - Obter assentos ocupados ⭐
- **CT065** - Filtrar sessões futuras ⭐
- **CT068** - Validar disponibilidade ⭐

### 🪑 **Reservas API** - 10 casos
- **CT089** - Criar reserva com dados válidos ⭐
- **CT090** - Criar reserva sem autenticação ⭐
- **CT091** - Reservar assento já ocupado ⭐
- **CT092** - Reservar múltiplos assentos ⭐
- **CT101** - Listar reservas do usuário ⭐
- **CT102** - Listar reservas sem autenticação ⭐
- **CT109** - Cancelar reserva própria ⭐
- **CT110** - Cancelar reserva de outro usuário ⭐
- **CT115** - Obter detalhes da reserva ⭐
- **CT100** - Reserva simultânea (concorrência) ⭐

**SUBTOTAL PRIORIDADE MÁXIMA: 32 casos**

---

## 🟡 **PRIORIDADE ALTA** (Automação Recomendada)

### 🔐 **Autenticação Web** - 6 casos
- **CT164** - Login via interface web
- **CT165** - Registro via interface web  
- **CT166** - Logout via interface web
- **CT167** - Redirecionamento após login
- **CT169** - Validação de formulários
- **CT170** - Mensagens de erro claras

### 🎬 **Filmes Web** - 4 casos
- **CT171** - Listagem de filmes na home
- **CT172** - Detalhes do filme
- **CT180** - Busca de filmes
- **CT173** - Seleção de sessão

### 🪑 **Reservas Web** - 6 casos
- **CT174** - Mapa de assentos interativo
- **CT175** - Seleção múltipla de assentos
- **CT177** - Finalização da reserva
- **CT178** - Histórico de reservas
- **CT179** - Cancelamento via web
- **CT181** - Fluxo completo de reserva

### 🔒 **Segurança** - 8 casos
- **CT125** - Acesso sem token
- **CT126** - Token malformado
- **CT127** - Assinatura inválida
- **CT128** - Token expirado
- **CT133** - Injeção SQL
- **CT134** - XSS
- **CT135** - Validação de tipos
- **CT140** - Rate limiting

### 📡 **API Behavior** - 6 casos
- **CT141** - Headers corretos
- **CT142** - Content-Type
- **CT143** - Status codes
- **CT144** - Estrutura de resposta
- **CT145** - Erro 404
- **CT146** - Erro 500

**SUBTOTAL PRIORIDADE ALTA: 30 casos**

---

## 🟢 **PRIORIDADE MÉDIA** (Automação Opcional)

### 🎭 **Validações Avançadas** - 12 casos
- **CT036** - Filtrar por gênero
- **CT037** - Filtrar por classificação
- **CT038** - Buscar por título
- **CT063** - Sessões por data
- **CT064** - Sessões por sala
- **CT103** - Filtrar reservas por status
- **CT104** - Filtrar reservas por data
- **CT105** - Ordenar reservas
- **CT025** - Atualizar nome perfil
- **CT026** - Atualizar senha
- **CT099** - Validar preço total
- **CT116** - Liberação de assentos

### 🌐 **Responsividade** - 4 casos
- **CT158** - Responsividade mobile
- **CT159** - Responsividade tablet
- **CT160** - Compatibilidade browsers
- **CT162** - Performance carregamento

### 🔄 **Fluxos Integrados** - 6 casos
- **CT182** - Fluxo cancelamento
- **CT183** - Registro + primeira reserva
- **CT184** - Múltiplas reservas simultâneas
- **CT185** - Reserva diferentes sessões
- **CT186** - Gestão de conflitos
- **CT187** - Sincronização dados

**SUBTOTAL PRIORIDADE MÉDIA: 22 casos**

---

## ❌ **NÃO RECOMENDADOS PARA AUTOMAÇÃO**

### 👁️ **Testes Visuais/UX** - 8 casos
- **CT156** - Layout página inicial
- **CT157** - Menu navegação
- **CT161** - Acessibilidade WCAG
- **CT163** - SEO básico
- **CT176** - Carrinho de compras (UX)
- **CT188** - Sessão lotada (visual)
- **CT192** - Notificações (UX)
- **CT193** - Relatórios (visual)

### 🏛️ **Funcionalidades Admin** - 10 casos
- **CT057-060** - Gestão de salas
- **CT081-088** - Gestão de sessões admin
- **CT117-124** - Gestão de usuários
- **CT194** - Análise de vendas

### 🚨 **Cenários Extremos** - 6 casos
- **CT195-200** - Disaster recovery, falhas de infraestrutura

### 🔍 **Testes Exploratórios** - 8 casos
- **CT149-155** - Performance detalhada
- **CT189** - Promoções complexas
- **CT190** - Reservas em grupo
- **CT191** - Lista de espera

**SUBTOTAL NÃO RECOMENDADOS: 32 casos**

---

## 📊 **RESUMO EXECUTIVO**

| Prioridade | Casos | % Total | Esforço | ROI |
|------------|-------|---------|---------|-----|
| 🔴 **Máxima** | 32 | 16% | Alto | Muito Alto |
| 🟡 **Alta** | 30 | 15% | Médio | Alto |
| 🟢 **Média** | 22 | 11% | Baixo | Médio |
| ❌ **Não Recomendado** | 32 | 16% | - | - |
| 📝 **Restantes** | 84 | 42% | - | - |

### 🎯 **RECOMENDAÇÃO FINAL**

**FASE 1 (MVP):** 32 casos prioritários (API + Fluxos críticos)  
**FASE 2 (Expansão):** +30 casos alta prioridade (Web + Segurança)  
**FASE 3 (Completa):** +22 casos média prioridade (Validações avançadas)

**COBERTURA AUTOMATIZADA RECOMENDADA: 84 casos (42% do total)**

### ⚡ **BENEFÍCIOS ESPERADOS**
- **Regressão:** 95% dos fluxos críticos cobertos
- **CI/CD:** Feedback rápido em cada deploy
- **Qualidade:** Detecção precoce de bugs
- **Produtividade:** Redução de testes manuais repetitivos
- **Confiança:** Deploy seguro em produção