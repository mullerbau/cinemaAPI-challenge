from pymongo import MongoClient
import os

def get_database_connection():
    """Conecta ao MongoDB"""
    connection_string = "mongodb://localhost:27017/"
    client = MongoClient(connection_string)
    return client

def cleanup_test_data():
    """Remove dados de teste do banco"""
    try:
        client = get_database_connection()
        db = client["cinema_app"]
        
        # Remove usuários de teste
        test_emails = [
            "bauer@teste.com",
            "bauerdup@teste.com", 
            "test@cinema.com"
        ]
        
        # Remove usuários
        result = db.users.delete_many({"email": {"$in": test_emails}})
        print(f"Removed {result.deleted_count} test users")
        
        # Remove reservas de usuários de teste
        users_to_remove = list(db.users.find({"email": {"$in": test_emails}}))
        user_ids = [str(user["_id"]) for user in users_to_remove]
        
        if user_ids:
            reservations_result = db.reservations.delete_many({"userId": {"$in": user_ids}})
            print(f"Removed {reservations_result.deleted_count} test reservations")
        
        client.close()
        return True
        
    except Exception as e:
        print(f"Error cleaning test data: {e}")
        return False

if __name__ == "__main__":
    cleanup_test_data()