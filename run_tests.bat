@echo off
echo Executando testes de automacao do Cinema App...

echo.
echo === Executando testes de API ===
robot -d results/api tests/api/

echo.
echo === Executando testes Web ===
robot -d results/web tests/web/

echo.
echo === Executando todos os testes ===
robot -d results/all tests/

echo.
echo Testes concluidos! Verifique os relatorios em results/
pause