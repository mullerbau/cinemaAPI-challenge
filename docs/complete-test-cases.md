# 📋 Casos de Teste Completos - Cinema App

## 🔐 MÓDULO: AUTENTICAÇÃO

### 📝 Registro de Usuário
**CT001** - Registro com dados válidos  
**CT002** - Registro com email já existente  
**CT003** - Registro sem nome  
**CT004** - Registro sem email  
**CT005** - Registro sem senha  
**CT006** - Registro com email inválido  
**CT007** - Registro com senha menor que 6 caracteres  
**CT008** - Registro com nome muito longo  
**CT009** - Registro com caracteres especiais no nome  
**CT010** - Registro com email com espaços  

### 🔑 Login de Usuário
**CT011** - Login com credenciais válidas  
**CT012** - Login com email inexistente  
**CT013** - Login com senha incorreta  
**CT014** - Login sem email  
**CT015** - Login sem senha  
**CT016** - Login com email inválido  
**CT017** - Login com campos vazios  
**CT018** - Login case-sensitive no email  
**CT019** - Login com espaços no email/senha  
**CT020** - Login após múltiplas tentativas falhadas  

### 👤 Perfil do Usuário
**CT021** - Obter perfil com token válido  
**CT022** - Obter perfil sem token  
**CT023** - Obter perfil com token inválido  
**CT024** - Obter perfil com token expirado  
**CT025** - Atualizar nome do perfil  
**CT026** - Atualizar senha com senha atual correta  
**CT027** - Atualizar senha com senha atual incorreta  
**CT028** - Atualizar perfil sem token  
**CT029** - Atualizar perfil com dados inválidos  
**CT030** - Atualizar perfil com nome vazio  

## 🎬 MÓDULO: FILMES

### 📋 Listagem de Filmes
**CT031** - Listar todos os filmes disponíveis  
**CT032** - Listar filmes quando não há filmes cadastrados  
**CT033** - Validar estrutura dos dados do filme  
**CT034** - Validar campos obrigatórios do filme  
**CT035** - Listar filmes com paginação  
**CT036** - Filtrar filmes por gênero  
**CT037** - Filtrar filmes por classificação  
**CT038** - Buscar filmes por título  
**CT039** - Ordenar filmes por título  
**CT040** - Ordenar filmes por duração  

### 🎭 Detalhes do Filme
**CT041** - Obter filme por ID válido  
**CT042** - Obter filme por ID inexistente  
**CT043** - Obter filme com ID inválido  
**CT044** - Validar todos os campos do filme  
**CT045** - Validar formato da duração  
**CT046** - Validar formato da classificação  
**CT047** - Validar sinopse do filme  
**CT048** - Validar URL do poster  
**CT049** - Validar gêneros do filme  
**CT050** - Obter filme sem parâmetros  

## 🏛️ MÓDULO: SALAS/TEATROS

### 🎪 Gestão de Salas
**CT051** - Listar todas as salas  
**CT052** - Obter sala por ID válido  
**CT053** - Obter sala por ID inexistente  
**CT054** - Validar capacidade da sala  
**CT055** - Validar layout dos assentos  
**CT056** - Validar tipos de assento  
**CT057** - Criar nova sala (admin)  
**CT058** - Atualizar dados da sala (admin)  
**CT059** - Excluir sala (admin)  
**CT060** - Operações de sala sem permissão  

## 🎫 MÓDULO: SESSÕES

### 📅 Listagem de Sessões
**CT061** - Listar todas as sessões  
**CT062** - Listar sessões por filme  
**CT063** - Listar sessões por data  
**CT064** - Listar sessões por sala  
**CT065** - Filtrar sessões futuras  
**CT066** - Filtrar sessões passadas  
**CT067** - Validar horários das sessões  
**CT068** - Validar disponibilidade de assentos  
**CT069** - Sessões com conflito de horário  
**CT070** - Sessões em salas inexistentes  

### 🕐 Detalhes da Sessão
**CT071** - Obter sessão por ID válido  
**CT072** - Obter sessão por ID inexistente  
**CT073** - Validar dados da sessão  
**CT074** - Validar preço da sessão  
**CT075** - Validar status da sessão  
**CT076** - Obter assentos disponíveis  
**CT077** - Obter assentos ocupados  
**CT078** - Validar mapa de assentos  
**CT079** - Sessão com todos assentos ocupados  
**CT080** - Sessão cancelada  

### ⚙️ Gestão de Sessões (Admin)
**CT081** - Criar nova sessão  
**CT082** - Atualizar sessão existente  
**CT083** - Cancelar sessão  
**CT084** - Excluir sessão  
**CT085** - Criar sessão com conflito  
**CT086** - Criar sessão no passado  
**CT087** - Operações sem permissão admin  
**CT088** - Validar regras de negócio  

## 🪑 MÓDULO: RESERVAS

### 📝 Criação de Reservas
**CT089** - Criar reserva com dados válidos  
**CT090** - Criar reserva sem autenticação  
**CT091** - Reservar assento já ocupado  
**CT092** - Reservar múltiplos assentos  
**CT093** - Reservar assento inexistente  
**CT094** - Reservar em sessão inexistente  
**CT095** - Reservar em sessão esgotada  
**CT096** - Reservar em sessão passada  
**CT097** - Reservar sem selecionar assentos  
**CT098** - Reservar mais assentos que disponível  
**CT099** - Validar preço total da reserva  
**CT100** - Reserva simultânea (concorrência)  

### 📋 Listagem de Reservas
**CT101** - Listar reservas do usuário  
**CT102** - Listar reservas sem autenticação  
**CT103** - Filtrar reservas por status  
**CT104** - Filtrar reservas por data  
**CT105** - Ordenar reservas por data  
**CT106** - Usuário sem reservas  
**CT107** - Paginação de reservas  
**CT108** - Validar dados das reservas  

### 🔄 Gestão de Reservas
**CT109** - Cancelar reserva própria  
**CT110** - Cancelar reserva de outro usuário  
**CT111** - Cancelar reserva inexistente  
**CT112** - Cancelar reserva já cancelada  
**CT113** - Cancelar reserva de sessão passada  
**CT114** - Atualizar reserva  
**CT115** - Obter detalhes da reserva  
**CT116** - Validar liberação de assentos  

## 👥 MÓDULO: USUÁRIOS

### 📊 Gestão de Usuários (Admin)
**CT117** - Listar todos os usuários (admin)  
**CT118** - Obter usuário por ID (admin)  
**CT119** - Atualizar dados de usuário (admin)  
**CT120** - Excluir usuário (admin)  
**CT121** - Promover usuário a admin  
**CT122** - Rebaixar admin para usuário  
**CT123** - Operações sem permissão admin  
**CT124** - Validar roles de usuário  

## 🔒 MÓDULO: SEGURANÇA

### 🛡️ Autenticação e Autorização
**CT125** - Acesso a endpoints protegidos sem token  
**CT126** - Token JWT malformado  
**CT127** - Token JWT com assinatura inválida  
**CT128** - Token JWT expirado  
**CT129** - Validar claims do token  
**CT130** - Refresh token (se implementado)  
**CT131** - Logout e invalidação de token  
**CT132** - Tentativas de força bruta  

### 🔐 Validações de Entrada
**CT133** - Injeção SQL nos campos  
**CT134** - XSS nos campos de texto  
**CT135** - Validação de tipos de dados  
**CT136** - Validação de tamanho de campos  
**CT137** - Caracteres especiais  
**CT138** - Encoding de caracteres  
**CT139** - Upload de arquivos maliciosos  
**CT140** - Rate limiting  

## 🌐 MÓDULO: API

### 📡 Comportamento da API
**CT141** - Headers de resposta corretos  
**CT142** - Content-Type adequado  
**CT143** - Status codes corretos  
**CT144** - Estrutura de resposta padronizada  
**CT145** - Tratamento de erros 404  
**CT146** - Tratamento de erros 500  
**CT147** - Validação de CORS  
**CT148** - Documentação Swagger acessível  

### ⚡ Performance e Limites
**CT149** - Tempo de resposta dos endpoints  
**CT150** - Limite de requisições por minuto  
**CT151** - Tamanho máximo de payload  
**CT152** - Timeout de requisições  
**CT153** - Conexões simultâneas  
**CT154** - Uso de memória  
**CT155** - Queries de banco otimizadas  

## 🖥️ MÓDULO: INTERFACE WEB

### 🏠 Navegação e Layout
**CT156** - Carregamento da página inicial  
**CT157** - Menu de navegação funcional  
**CT158** - Responsividade mobile  
**CT159** - Responsividade tablet  
**CT160** - Compatibilidade com browsers  
**CT161** - Acessibilidade (WCAG)  
**CT162** - Performance de carregamento  
**CT163** - SEO básico  

### 🔐 Autenticação Web
**CT164** - Login via interface web  
**CT165** - Registro via interface web  
**CT166** - Logout via interface web  
**CT167** - Redirecionamento após login  
**CT168** - Persistência de sessão  
**CT169** - Validação de formulários  
**CT170** - Mensagens de erro claras  

### 🎬 Funcionalidades do Cinema
**CT171** - Listagem de filmes na home  
**CT172** - Detalhes do filme  
**CT173** - Seleção de sessão  
**CT174** - Mapa de assentos interativo  
**CT175** - Seleção múltipla de assentos  
**CT176** - Carrinho de compras  
**CT177** - Finalização da reserva  
**CT178** - Histórico de reservas  
**CT179** - Cancelamento via web  
**CT180** - Busca de filmes  

## 🔄 MÓDULO: INTEGRAÇÃO

### 🔗 Fluxos End-to-End
**CT181** - Fluxo completo de reserva  
**CT182** - Fluxo de cancelamento  
**CT183** - Fluxo de registro e primeira reserva  
**CT184** - Múltiplas reservas simultâneas  
**CT185** - Reserva em diferentes sessões  
**CT186** - Gestão de conflitos  
**CT187** - Sincronização de dados  

### 📊 Cenários de Negócio
**CT188** - Sessão lotada  
**CT189** - Promoções e descontos  
**CT190** - Reservas em grupo  
**CT191** - Lista de espera  
**CT192** - Notificações de confirmação  
**CT193** - Relatórios de ocupação  
**CT194** - Análise de vendas  

## 🚨 MÓDULO: CENÁRIOS CRÍTICOS

### ⚠️ Casos Extremos
**CT195** - Falha na conexão com banco  
**CT196** - Servidor sobrecarregado  
**CT197** - Dados corrompidos  
**CT198** - Backup e recuperação  
**CT199** - Manutenção programada  
**CT200** - Disaster recovery  

---

## 📊 RESUMO POR CATEGORIA

| Módulo | Quantidade | Prioridade |
|--------|------------|------------|
| Autenticação | 30 | Alta |
| Filmes | 20 | Alta |
| Salas/Teatros | 10 | Média |
| Sessões | 28 | Alta |
| Reservas | 28 | Crítica |
| Usuários | 8 | Média |
| Segurança | 16 | Alta |
| API | 15 | Alta |
| Interface Web | 25 | Alta |
| Integração | 14 | Crítica |
| Cenários Críticos | 6 | Média |

**TOTAL: 200 Casos de Teste**

## 🎯 CRITÉRIOS DE PRIORIZAÇÃO

### 🔴 **Crítica** (Reservas, Integração)
- Funcionalidades core do negócio
- Fluxos que geram receita
- Experiência do usuário final

### 🟡 **Alta** (Auth, Filmes, Sessões, Segurança, API, Web)
- Funcionalidades essenciais
- Segurança da aplicação
- Usabilidade básica

### 🟢 **Média** (Salas, Usuários, Cenários Críticos)
- Funcionalidades administrativas
- Casos extremos
- Melhorias de experiência