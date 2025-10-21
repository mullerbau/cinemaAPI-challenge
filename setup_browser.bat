@echo off
echo Instalando dependencias do Robot Framework...
pip install -r requirements.txt

echo.
echo Inicializando Browser Library...
rfbrowser init

echo.
echo Setup concluido! Agora voce pode executar os testes.
pause