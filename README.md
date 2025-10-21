# 🎬 Cinema Test Automation Challenge

## 👨‍💻 Sobre o Autor
**Nome:** Eric Bauer  
**Challenge Final**  
**Compass UOL**  

## 📋 Descrição do Projeto
Projeto de automação de testes para aplicação de cinema desenvolvido como challenge final do curso de automação de testes. O projeto abrange testes de API e interface web utilizando Robot Framework.

## 🏗️ Estrutura do Projeto
```
challenge_final-uol/
├── docs/                    # Documentação e análises
│   ├── test-plan.md        # Plano de testes
│   ├── mind-map.png        # Mapa mental
│   └── test-scenarios.md   # Cenários de teste
├── tests/                  # Testes automatizados
│   ├── api/               # Testes de API
│   ├── web/               # Testes de interface web
│   └── resources/         # Recursos compartilhados
├── keywords/              # Keywords customizadas
├── variables/             # Variáveis globais
├── results/              # Relatórios de execução
└── README.md            # Este arquivo
```

## 🚀 Pré-requisitos
- Python 3.8+
- Robot Framework
- SeleniumLibrary
- RequestsLibrary
- Chrome/Firefox WebDriver

## ⚙️ Instalação
```bash
# Clonar o repositório
git clone https://github.com/mullerbau/cinemaAPI-challenge

# Instalar dependências
pip install -r requirements.txt
```

## 🎯 Execução dos Testes
```bash
# Executar todos os testes
robot tests/

# Executar apenas testes de API
robot tests/api/

# Executar apenas testes web
robot tests/web/
```

## 📊 Relatórios
Os relatórios são gerados automaticamente na pasta `results/` após cada execução.

## 🐛 Issues Identificadas
- [Lista será atualizada durante os testes]

## 🤝 Colaboradores
- [Mencionar colegas que ajudaram]

## 📝 Notas Adicionais
Este projeto foi desenvolvido seguindo as melhores práticas de automação de testes e padrões como Page Objects e Service Objects.