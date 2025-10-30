#!/usr/bin/env python3
"""
Exemplos de uso do Data Manager para diferentes cenários de teste
"""

from data_manager import CinemaDataManager

def exemplo_teste_login_sucesso():
    """Exemplo: Preparar dados para teste de login com sucesso"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Preparando dados para: Login com sucesso")
        
        # Limpa e cria usuário específico para o teste
        user_id = dm.create_test_user(
            name="Usuário Teste Login",
            email="login_success@test.com", 
            password="123456"
        )
        
        print(f"✅ Usuário preparado para teste de login: {user_id}")
        return user_id
        
    finally:
        dm.close_connection()

def exemplo_teste_login_falha():
    """Exemplo: Preparar dados para teste de login com falha"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Preparando dados para: Login com falha")
        
        # Para teste de falha, NÃO criamos o usuário
        # Apenas garantimos que ele não existe
        dm.clean_test_user("login_fail@test.com")
        
        print("✅ Usuário removido - teste de falha preparado")
        
    finally:
        dm.close_connection()

def exemplo_teste_registro_email_existente():
    """Exemplo: Preparar dados para teste de registro com email já existente"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Preparando dados para: Registro com email existente")
        
        # Cria usuário que já deve existir para o teste falhar
        existing_user = dm.create_test_user(
            name="Usuário Já Existente",
            email="existing@test.com",
            password="123456"
        )
        
        print(f"✅ Usuário existente preparado: {existing_user}")
        print("⚠️  Agora o teste de registro deve falhar com 'email já existe'")
        
    finally:
        dm.close_connection()

def exemplo_teste_filme_inexistente():
    """Exemplo: Preparar dados para teste de filme inexistente"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Preparando dados para: Filme inexistente")
        
        # Remove filme específico para garantir que não existe
        dm.clean_test_movie(title="Filme Inexistente")
        
        print("✅ Filme removido - teste de 404 preparado")
        
    finally:
        dm.close_connection()

def exemplo_setup_completo_reserva():
    """Exemplo: Setup completo para teste de reserva"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Preparando dados completos para: Teste de reserva")
        
        # 1. Cria usuário
        user_id = dm.create_test_user(
            name="Usuário Reserva",
            email="reserva@test.com",
            password="123456"
        )
        
        # 2. Cria filme
        movie_id = dm.create_test_movie(
            title="Filme para Reserva",
            synopsis="Filme usado nos testes de reserva",
            director="Diretor Teste",
            genres=["Ação"],
            duration=120,
            classification="PG-13",
            custom_id="reserva-movie-001"
        )
        
        # 3. Limpa reservas antigas do usuário
        dm.clean_test_reservations_by_user(user_id)
        
        print(f"✅ Setup completo:")
        print(f"   - Usuário: {user_id}")
        print(f"   - Filme: {movie_id}")
        print("   - Reservas antigas limpas")
        
        return {
            "user_id": user_id,
            "movie_id": movie_id
        }
        
    finally:
        dm.close_connection()

def exemplo_limpeza_pos_teste():
    """Exemplo: Limpeza após execução de testes"""
    dm = CinemaDataManager()
    
    try:
        print("📝 Executando limpeza pós-teste...")
        
        # Remove dados específicos criados durante os testes
        dm.clean_test_users_by_pattern("test")
        dm.clean_test_movie(custom_id="reserva-movie-001")
        
        print("✅ Limpeza pós-teste concluída")
        
    finally:
        dm.close_connection()

if __name__ == "__main__":
    print("🎬 Exemplos de uso do Data Manager\n")
    
    # Executa exemplos
    exemplo_teste_login_sucesso()
    print()
    
    exemplo_teste_login_falha()
    print()
    
    exemplo_teste_registro_email_existente()
    print()
    
    exemplo_teste_filme_inexistente()
    print()
    
    exemplo_setup_completo_reserva()
    print()
    
    # exemplo_limpeza_pos_teste()  # Descomente para limpar