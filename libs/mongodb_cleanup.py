#!/usr/bin/env python3
"""
MongoDB Cleanup Utility for Cinema App Tests
Limpa dados de teste do banco MongoDB antes/depois da execução dos testes
"""

import pymongo
import os
from datetime import datetime

class MongoDBCleanup:
    def __init__(self):
        # Configuração da conexão MongoDB
        self.mongo_uri = os.getenv('MONGODB_URI', 'mongodb://localhost:27017')
        self.database_name = os.getenv('DB_NAME', 'cinema_app')
        self.client = None
        self.db = None
        
    def connect(self):
        """Conecta ao MongoDB"""
        try:
            self.client = pymongo.MongoClient(self.mongo_uri)
            self.db = self.client[self.database_name]
            # Testa a conexão
            self.client.admin.command('ping')
            print(f"✅ Conectado ao MongoDB: {self.database_name}")
            return True
        except Exception as e:
            print(f"❌ Erro ao conectar MongoDB: {e}")
            return False
    
    def cleanup_test_users(self):
        """Remove usuários de teste"""
        try:
            test_emails = [
                'test@cinema.com',
                'testuser@example.com',
                'user@test.com',
                'invalid@email.com',
                'newuser@test.com'
            ]
            
            result = self.db.users.delete_many({
                "$or": [
                    {"email": {"$in": test_emails}},
                    {"email": {"$regex": "test.*@.*"}},
                    {"name": {"$regex": "Test.*"}}
                ]
            })
            
            print(f"🗑️ Removidos {result.deleted_count} usuários de teste")
            return result.deleted_count
            
        except Exception as e:
            print(f"❌ Erro ao limpar usuários: {e}")
            return 0
    
    def cleanup_test_reservations(self):
        """Remove reservas de teste"""
        try:
            # Remove reservas de usuários de teste
            result = self.db.reservations.delete_many({
                "$or": [
                    {"userEmail": {"$regex": "test.*@.*"}},
                    {"status": "test"},
                    {"createdAt": {"$gte": datetime.now().replace(hour=0, minute=0, second=0)}}
                ]
            })
            
            print(f"🗑️ Removidas {result.deleted_count} reservas de teste")
            return result.deleted_count
            
        except Exception as e:
            print(f"❌ Erro ao limpar reservas: {e}")
            return 0
    
    def reset_session_seats(self):
        """Reseta assentos das sessões para estado inicial"""
        try:
            result = self.db.sessions.update_many(
                {},
                {"$unset": {"reservedSeats": "", "occupiedSeats": ""}}
            )
            
            print(f"🔄 Resetados assentos de {result.modified_count} sessões")
            return result.modified_count
            
        except Exception as e:
            print(f"❌ Erro ao resetar assentos: {e}")
            return 0
    
    def cleanup_all(self):
        """Executa limpeza completa"""
        if not self.connect():
            return False
            
        print("🧹 Iniciando limpeza do banco de dados...")
        
        users_cleaned = self.cleanup_test_users()
        reservations_cleaned = self.cleanup_test_reservations()
        sessions_reset = self.reset_session_seats()
        
        print(f"✅ Limpeza concluída:")
        print(f"   - Usuários: {users_cleaned}")
        print(f"   - Reservas: {reservations_cleaned}")
        print(f"   - Sessões: {sessions_reset}")
        
        return True
    
    def close(self):
        """Fecha conexão"""
        if self.client:
            self.client.close()
            print("🔌 Conexão MongoDB fechada")

def cleanup_database():
    """Função principal para limpeza"""
    cleanup = MongoDBCleanup()
    success = cleanup.cleanup_all()
    cleanup.close()
    return success

if __name__ == "__main__":
    cleanup_database()