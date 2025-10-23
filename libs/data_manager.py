#!/usr/bin/env python3
"""
Data Manager para Cinema App - Gerenciamento de Massa de Dados
Limpa dados específicos antes dos testes para garantir consistência
"""

from robot.api.deco import keyword
from pymongo import MongoClient
from datetime import datetime, timedelta
import bcrypt
import json

# Conexão global com MongoDB
client = MongoClient('mongodb+srv://bauer:teste123@cinemaasap.zdktlgv.mongodb.net/?retryWrites=true&w=majority&appName=cinemaAsap')
db = client.get_database()  # Usa database padrão da URI

# ==================== USUÁRIOS ====================

@keyword('Clean user from database')
def clean_user(user_email):
    """Remove usuário e suas reservas do banco"""
    users = db['users']
    reservations = db['reservations']
    
    u = users.find_one({'email': user_email})
    
    if u:
        # Remove reservas do usuário primeiro
        reservations.delete_many({'user': u['_id']})
        # Remove o usuário
        users.delete_many({'email': user_email})
        print(f"Removed user {user_email} and their reservations")
    else:
        print(f"User {user_email} not found")

@keyword('Remove user from database')
def remove_user(email):
    """Remove usuário por email"""
    users = db['users']
    result = users.delete_many({'email': email})
    print(f"Removed {result.deleted_count} users with email: {email}")
    return result.deleted_count

@keyword('Clean test users from database')
def clean_test_users():
    """Remove usuários de teste por padrão"""
    users = db['users']
    reservations = db['reservations']
    
    # Busca usuários de teste
    test_users = users.find({
        '$or': [
            {'email': {'$regex': 'test.*@'}},
            {'email': {'$regex': '.*test\.com'}},
            {'email': {'$regex': 'bauer.*@'}}
        ]
    })
    
    user_ids = [user['_id'] for user in test_users]
    
    if user_ids:
        # Remove reservas dos usuários de teste
        reservations.delete_many({'user': {'$in': user_ids}})
        # Remove usuários de teste
        result = users.delete_many({'_id': {'$in': user_ids}})
        print(f"Cleaned {result.deleted_count} test users and their reservations")
        return result.deleted_count
    else:
        print("No test users found")
        return 0

@keyword('Insert user in database')
def insert_user(user):
    """Insere usuário no banco com senha hasheada"""
    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))
    
    doc = {
        'name': user['name'],
        'email': user['email'].lower(),
        'password': hash_pass,
        'role': user.get('role', 'user'),
        'createdAt': datetime.now()
    }
    
    users = db['users']
    result = users.insert_one(doc)
    print(f"Inserted user {user['email']} with ID: {result.inserted_id}")
    return str(result.inserted_id)

@keyword('Create test user')
def create_test_user(name, email, password, role="user"):
    """Cria usuário de teste (limpa antes se existir)"""
    # Remove usuário existente primeiro
    clean_user(email)
    
    # Cria novo usuário
    user_data = {
        'name': name,
        'email': email,
        'password': password,
        'role': role
    }
    
    return insert_user(user_data)

# ==================== FILMES ====================

@keyword('Clean movie from database')
def clean_movie(movie_title=None, custom_id=None):
    """Remove filme e suas sessões/reservas do banco"""
    movies = db['movies']
    sessions = db['sessions']
    reservations = db['reservations']
    
    query = {}
    if movie_title:
        query['title'] = {'$regex': movie_title, '$options': 'i'}
    if custom_id:
        query['customId'] = custom_id
        
    if not query:
        print("Specify movie title or customId")
        return False
        
    movie = movies.find_one(query)
    
    if movie:
        # Remove reservas das sessões do filme
        movie_sessions = sessions.find({'movie': movie['_id']})
        session_ids = [session['_id'] for session in movie_sessions]
        
        if session_ids:
            reservations.delete_many({'session': {'$in': session_ids}})
            sessions.delete_many({'movie': movie['_id']})
            
        # Remove o filme
        movies.delete_one({'_id': movie['_id']})
        identifier = movie_title or custom_id
        print(f"Removed movie '{identifier}' and related data")
        return True
    else:
        print(f"Movie not found")
        return False

@keyword('Remove movie from database')
def remove_movie(title):
    """Remove filme por título"""
    movies = db['movies']
    result = movies.delete_many({'title': {'$regex': title, '$options': 'i'}})
    print(f"Removed {result.deleted_count} movies with title: {title}")
    return result.deleted_count

@keyword('Insert movie in database')
def insert_movie(movie):
    """Insere filme no banco"""
    doc = {
        'title': movie['title'],
        'synopsis': movie['synopsis'],
        'director': movie['director'],
        'genres': movie['genres'] if isinstance(movie['genres'], list) else [movie['genres']],
        'duration': movie['duration'],
        'classification': movie['classification'],
        'poster': movie.get('poster', 'no-image.jpg'),
        'releaseDate': movie.get('releaseDate', datetime.now() - timedelta(days=30)),
        'createdAt': datetime.now()
    }
    
    if 'customId' in movie:
        doc['customId'] = movie['customId']
    
    movies = db['movies']
    result = movies.insert_one(doc)
    print(f"Inserted movie {movie['title']} with ID: {result.inserted_id}")
    return str(result.inserted_id)

@keyword('Create test movie')
def create_test_movie(title, synopsis, director, genres, duration, classification, custom_id=None):
    """Cria filme de teste (limpa antes se existir)"""
    # Remove filme existente primeiro
    clean_movie(movie_title=title, custom_id=custom_id)
    
    # Cria novo filme
    movie_data = {
        'title': title,
        'synopsis': synopsis,
        'director': director,
        'genres': genres,
        'duration': duration,
        'classification': classification
    }
    
    if custom_id:
        movie_data['customId'] = custom_id
        
    return insert_movie(movie_data)

# ==================== RESERVAS ====================

@keyword('Clean reservations from database')
def clean_reservations():
    """Remove todas as reservas de teste"""
    reservations = db['reservations']
    result = reservations.delete_many({})
    print(f"Cleaned {result.deleted_count} reservations from database")
    return result.deleted_count

@keyword('Clean user reservations')
def clean_user_reservations(user_email):
    """Remove reservas de um usuário específico"""
    users = db['users']
    reservations = db['reservations']
    
    user = users.find_one({'email': user_email})
    if user:
        result = reservations.delete_many({'user': user['_id']})
        print(f"Cleaned {result.deleted_count} reservations for user {user_email}")
        return result.deleted_count
    else:
        print(f"User {user_email} not found")
        return 0

# ==================== LIMPEZA GERAL ====================

@keyword('Clean all test data')
def clean_all_test_data():
    """Remove todos os dados de teste"""
    print("🧹 Cleaning all test data...")
    
    users_count = clean_test_users()
    reservations_count = clean_reservations()
    
    print(f"✅ Cleaned: {users_count} users, {reservations_count} reservations")
    return {
        'users': users_count,
        'reservations': reservations_count
    }

# ==================== UTILITÁRIOS ====================

@keyword('Get user by email')
def get_user_by_email(email):
    """Busca usuário por email"""
    users = db['users']
    user = users.find_one({'email': email.lower()})
    return user

@keyword('Get movie by title')
def get_movie_by_title(title):
    """Busca filme por título"""
    movies = db['movies']
    movie = movies.find_one({'title': {'$regex': title, '$options': 'i'}})
    return movie

# ==================== FUNÇÕES DE CONVENIÊNCIA ====================

@keyword('Setup basic test data')
def setup_basic_test_data():
    """Configura dados básicos para testes"""
    print("🚀 Setting up basic test data...")
    
    # Cria usuários de teste
    user_id = create_test_user("Usuário Teste", "test@cinema.com", "123456")
    admin_id = create_test_user("Admin Teste", "admin@cinema.com", "admin123", "admin")
    
    # Cria filme de teste
    movie_id = create_test_movie(
        "Filme de Teste",
        "Sinopse do filme de teste para automação",
        "Diretor Teste",
        ["Ação", "Drama"],
        120,
        "PG-13",
        "test-movie-001"
    )
    
    print("✅ Basic test data configured successfully!")
    return {
        'user_id': user_id,
        'admin_id': admin_id,
        'movie_id': movie_id
    }

if __name__ == "__main__":
    print("🎬 Cinema Data Manager - Robot Framework Keywords")
    print("Import this file in Robot Framework to use the keywords")
    print("Available keywords:")
    print("  - Clean user from database")
    print("  - Create test user")
    print("  - Clean movie from database")
    print("  - Create test movie")
    print("  - Clean all test data")
    print("  - Setup basic test data")