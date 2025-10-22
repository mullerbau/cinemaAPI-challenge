@echo off
echo 🎬 Testando Data Manager do Cinema App
echo.

echo === Instalando dependencias ===
pip install pymongo python-dotenv

echo.
echo === Status inicial do banco ===
python utils/data_manager.py status

echo.
echo === Configurando dados basicos ===
python utils/data_manager.py setup

echo.
echo === Status apos setup ===
python utils/data_manager.py status

echo.
echo === Testando exemplos ===
python utils/test_data_examples.py

echo.
echo === Limpeza final ===
python utils/data_manager.py clean

echo.
echo === Status final ===
python utils/data_manager.py status

echo.
echo ✅ Teste do Data Manager concluido!
pause