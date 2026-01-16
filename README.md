# 🛒 Desafio Fullstack IN8 - E-Commerce

Este repositório contém a solução para o desafio técnico de Desenvolvedor Júnior. A aplicação consiste em um ecossistema completo de e-commerce, integrando APIs de fornecedores externos, processamento de dados no backend e uma interface reativa no frontend.

---

## 💡 Processo de Desenvolvimento e Tomada de Decisões

O projeto foi estruturado focando em **escalabilidade**, **experiência do usuário (UX)** e **integridade de dados**.

### 1. Arquitetura do Backend (NestJS + TypeORM)
Optei pelo **NestJS** devido à sua arquitetura modular, que facilita a manutenção. 
- **Unificação de Dados:** Criei um serviço que consome simultaneamente os fornecedores da Europa e do Brasil, padronizando campos divergentes (como `name` vs `nome`) antes de enviar ao frontend.
- **Segurança:** Implementei DTOs (Data Transfer Objects) com validação rigorosa. Isso garante que o banco de dados nunca receba um pedido sem e-mail ou com valores inconsistentes.

### 2. Arquitetura do Frontend (Flutter Web)
O frontend foi desenvolvido para ser intuitivo e rápido.
- **Gerenciamento de Estado:** Utilizei o **Provider** para gerenciar o carrinho de compras. Isso permite que a interface reaja instantaneamente às ações do usuário (adicionar/remover) sem a necessidade de recarregar a página.
- **Filtros Inteligentes:** Implementei lógica de busca por texto e filtros por origem (Brasil/Europa) via Radio Buttons, permitindo uma navegação fluida.

### 3. Persistência de Dados
Utilizei o **PostgreSQL** para garantir a persistência dos pedidos, modelando uma relação que armazena os dados do cliente e a lista de produtos comprados em cada transação.

---

## 🛠️ Tecnologias e Dependências

### Backend (Node.js/NestJS)
- `@nestjs/typeorm` e `typeorm`: Para comunicação com o banco de dados.
- `class-validator` e `class-transformer`: Para validação de dados de entrada.
- `axios` ou `http`: Para consumo das APIs dos fornecedores.
- `pg`: Driver do PostgreSQL.

### Frontend (Flutter)
- `provider`: Gerenciamento de estado do carrinho.
- `http`: Para consumo da API NestJS.

---

## 🚀 Como Rodar o Projeto

### 1. Pré-requisitos
- Node.js instalado (v16 ou superior)
- Flutter SDK instalado e configurado
- Banco de Dados PostgreSQL ativo

### 2. Configuração do Backend
1. Entre na pasta `backend`: `cd backend-ecommerce`
2. Instale as dependências: `npm install`
3. Configure o banco de dados no arquivo `src/app.module.ts` (ou no seu `.env`).
4. Inicie o servidor: `npm run start:dev`
   > O servidor rodará em: `http://localhost:3000`

### 3. Configuração do Frontend
1. Entre na pasta `frontend`: `cd ecommerce_frontend`
2. Baixe os pacotes: `flutter pub get`
3. Rode a aplicação na porta 8080:
   ```bash
   flutter run -d chrome --web-port 8080