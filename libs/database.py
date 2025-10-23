from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://qa:xperience@cluster0.vaxstrc.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0')

db = client['test']

@keyword('Clean user from database')
def clean_user(user_email):
    
    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})
    
    if (u):
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})
    
    
    
@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    result = users.delete_many({'email': email})
    print(f"Removed {result.deleted_count} users with email: {email}")
    return result.deleted_count
    

@keyword('Insert user from database')    
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))
    
    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }
    users = db['users']
    users.insert_one(doc)
    print(user)

@keyword('Clean test users from database')
def clean_test_users():
    users = db['users']
    # Remove usuários de teste (emails que contêm 'eric' ou 'bauer')
    result = users.delete_many({
        '$or': [
            {'email': {'$regex': 'eric.*@gmail.com'}},
            {'email': {'$regex': 'bauer.*@gmail.com'}}
        ]
    })
    print(f"Cleaned {result.deleted_count} test users from database")
    return result.deleted_count