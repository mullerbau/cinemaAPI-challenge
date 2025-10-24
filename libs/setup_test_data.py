import requests
import json
from datetime import datetime, timedelta

BASE_URL = "http://localhost:3000/api/v1"

def create_admin_user():
    """Cria usuário admin para setup"""
    admin_data = {
        "name": "Admin Test",
        "email": "admin@test.com", 
        "password": "admin123"
    }
    
    response = requests.post(f"{BASE_URL}/setup/admin", json=admin_data)
    if response.status_code in [200, 201]:
        print("Admin user created/exists")
        return admin_data
    else:
        print(f"Error creating admin: {response.text}")
        return None

def login_admin():
    """Faz login do admin e retorna token"""
    login_data = {
        "email": "admin@test.com",
        "password": "admin123"
    }
    
    response = requests.post(f"{BASE_URL}/auth/login", json=login_data)
    if response.status_code == 200:
        token = response.json()["data"]["token"]
        print("Admin logged in successfully")
        return token
    else:
        print(f"Error logging in admin: {response.text}")
        return None

def create_theater(token):
    """Cria teatro de teste"""
    theater_data = {
        "name": "Theater Test 1",
        "capacity": 50,
        "type": "standard"
    }
    
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(f"{BASE_URL}/theaters", json=theater_data, headers=headers)
    
    if response.status_code == 201:
        theater_id = response.json()["data"]["_id"]
        print(f"Theater created: {theater_id}")
        return theater_id
    else:
        print(f"Error creating theater: {response.text}")
        return None

def create_session(token, movie_id, theater_id):
    """Cria sessão de teste"""
    future_date = datetime.now() + timedelta(days=1)
    session_data = {
        "movie": movie_id,
        "theater": theater_id,
        "datetime": future_date.isoformat(),
        "fullPrice": 20.0,
        "halfPrice": 10.0
    }
    
    headers = {"Authorization": f"Bearer {token}"}
    response = requests.post(f"{BASE_URL}/sessions", json=session_data, headers=headers)
    
    if response.status_code == 201:
        session_id = response.json()["data"]["_id"]
        print(f"Session created: {session_id}")
        return session_id
    else:
        print(f"Error creating session: {response.text}")
        return None

def get_first_movie():
    """Pega o primeiro filme disponível"""
    response = requests.get(f"{BASE_URL}/movies")
    if response.status_code == 200:
        movies = response.json()["data"]
        if movies:
            movie_id = movies[0]["_id"]
            print(f"Using movie: {movie_id}")
            return movie_id
    return None

def setup_test_data():
    """Setup completo dos dados de teste"""
    print("Setting up test data...")
    
    # Criar admin
    admin_data = create_admin_user()
    if not admin_data:
        return False
    
    # Login admin
    token = login_admin()
    if not token:
        return False
    
    # Pegar primeiro filme
    movie_id = get_first_movie()
    if not movie_id:
        print("No movies found")
        return False
    
    # Criar teatro
    theater_id = create_theater(token)
    if not theater_id:
        return False
    
    # Criar sessão
    session_id = create_session(token, movie_id, theater_id)
    if not session_id:
        return False
    
    print("Test data setup completed successfully!")
    return True

if __name__ == "__main__":
    setup_test_data()