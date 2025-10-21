# 🎭 Cenários de Teste - Cinema App

## 🔐 Cenários de Autenticação

### CT001 - Login com credenciais válidas
**Dado** que o usuário possui credenciais válidas  
**Quando** realizar login com email e senha corretos  
**Então** deve ser autenticado com sucesso e receber token JWT  

### CT002 - Login com credenciais inválidas
**Dado** que o usuário possui credenciais inválidas  
**Quando** tentar fazer login  
**Então** deve receber mensagem de erro de autenticação  

### CT003 - Registro de novo usuário
**Dado** que o usuário não possui conta  
**Quando** preencher formulário de registro com dados válidos  
**Então** deve criar conta com sucesso  

## 🎬 Cenários de Filmes

### CT004 - Listar filmes disponíveis
**Dado** que existem filmes cadastrados  
**Quando** acessar a lista de filmes  
**Então** deve exibir todos os filmes com informações básicas  

### CT005 - Visualizar detalhes do filme
**Dado** que existe um filme específico  
**Quando** clicar no filme  
**Então** deve exibir detalhes completos (sinopse, duração, gênero)  

## 🎫 Cenários de Sessões

### CT006 - Listar sessões de um filme
**Dado** que um filme possui sessões disponíveis  
**Quando** acessar as sessões do filme  
**Então** deve exibir horários, salas e disponibilidade  

### CT007 - Validar sessões esgotadas
**Dado** que uma sessão está esgotada  
**Quando** tentar acessar a sessão  
**Então** deve indicar que não há assentos disponíveis  

## 🪑 Cenários de Reservas

### CT008 - Realizar reserva com sucesso
**Dado** que o usuário está logado  
**E** existe uma sessão com assentos disponíveis  
**Quando** selecionar assentos e confirmar reserva  
**Então** deve criar reserva e bloquear os assentos  

### CT009 - Tentar reservar assento ocupado
**Dado** que um assento já está reservado  
**Quando** tentar reservar o mesmo assento  
**Então** deve exibir erro informando que assento não está disponível  

### CT010 - Cancelar reserva
**Dado** que o usuário possui uma reserva ativa  
**Quando** cancelar a reserva  
**Então** deve liberar os assentos e remover a reserva  

### CT011 - Listar minhas reservas
**Dado** que o usuário possui reservas  
**Quando** acessar "Minhas Reservas"  
**Então** deve exibir todas as reservas do usuário  

## 🌐 Cenários de Interface Web

### CT012 - Navegação responsiva
**Dado** que o usuário acessa em diferentes dispositivos  
**Quando** navegar pela aplicação  
**Então** deve manter usabilidade em mobile e desktop  

### CT013 - Fluxo completo de reserva
**Dado** que o usuário não está logado  
**Quando** tentar fazer uma reserva  
**Então** deve ser redirecionado para login  
**E** após login, continuar o fluxo de reserva  

## ❌ Cenários Negativos

### CT014 - API sem autenticação
**Dado** que o usuário não está autenticado  
**Quando** tentar acessar endpoints protegidos  
**Então** deve retornar erro 401 Unauthorized  

### CT015 - Dados inválidos na API
**Dado** que são enviados dados inválidos  
**Quando** fazer requisição para API  
**Então** deve retornar erro 400 Bad Request com detalhes  

### CT016 - Recurso não encontrado
**Dado** que um recurso não existe  
**Quando** tentar acessá-lo  
**Então** deve retornar erro 404 Not Found