# Usa a imagem oficial do Node.js como base
FROM node:18

# Instalar dependências do Chromium
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

# Define o diretório de trabalho
WORKDIR /app

# Clona o repositório
RUN git clone https://github.com/cadastrobrasildev/webscrapper.git .

# Instala as dependências do projeto
RUN npm install

# Instala Puppeteer separadamente para garantir que ele baixe o Chromium correto
RUN npm install puppeteer@latest

# Corrige permissões do Chromium dentro do Docker
RUN chmod -R 777 /app/node_modules/puppeteer/.local-chromium

# Define o comando de inicialização
CMD ["npm", "run", "scrap_google"]

# Expor a porta (se necessário)
EXPOSE 3000
