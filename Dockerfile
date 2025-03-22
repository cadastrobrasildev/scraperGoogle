# Usa a imagem oficial do Node.js como base
FROM node:18

# Instalar dependências do Chromium necessárias para Puppeteer
RUN apt-get update && apt-get install -y \
  curl \
  git \
  libasound2 \
  libnss3 \
  libatk1.0-0 \
  libatk-bridge2.0-0 \
  libcups2 \
  libdrm2 \
  libxkbcommon0 \
  libxcomposite1 \
  libxdamage1 \
  libxrandr2 \
  libgbm1 \
  libpango1.0-0 \
  libxshmfence1 \
  libglu1-mesa \
  libxtst6 \
  libx11-xcb1 \
  libxrender1 \
  libxi6 \
  libdbus-glib-1-2 \
  libxfixes3 \
  libxcursor1 \
  libxss1 \
  libglib2.0-0 \
  libnss3-dev \
  libgconf-2-4 \
  libgtk-3-0 \
  ca-certificates \
  fonts-liberation \
  libappindicator3-1 \
  lsb-release \
  xdg-utils \
  --no-install-recommends

# Define o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copia os arquivos do package.json e package-lock.json antes do código-fonte
COPY package.json ./

# **Garante que todas as dependências do projeto sejam instaladas corretamente**
RUN npm install 

# Copia os arquivos do projeto para dentro do container
COPY . .

# Define a variável para forçar o download do Chromium
ENV PUPPETEER_SKIP_DOWNLOAD=false

# Instala manualmente o Puppeteer para garantir que Chromium seja baixado corretamente
RUN npm install puppeteer@latest

# Define o comando de inicialização da aplicação
CMD ["npm", "run", "scrap_google"]

# Expor a porta (caso seja necessário)
EXPOSE 3000
