# Etapa 1: build
FROM node:20-alpine AS builder

# Diretório de trabalho dentro do container
WORKDIR /app

# Copia package.json e package-lock.json primeiro para cache de dependências
COPY package*.json ./

# Instala dependências
RUN npm install --production

# Copia todo o código
COPY . .

# Etapa 2: imagem final leve
FROM node:20-alpine

WORKDIR /app

# Copia apenas o necessário da build
COPY --from=builder /app /app

# Expõe a porta
EXPOSE 8080

# Comando padrão
CMD ["node", "index.js"]
