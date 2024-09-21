# Usar a imagem base do Ubuntu 24.10 no ECR público- Recebida com argumento
ARG BASE_REPOSITORY_URI
FROM $BASE_REPOSITORY_URI

# Ajuda com instalações silenciosas
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes
RUN apt-get -qq update > /dev/null

# Instalar apt-utils para evitar alertas
RUN apt-get -qq install apt-utils > /dev/null

# Instalar pre-requisitos gerais
RUN apt-get -qq install wget unzip > /dev/null

# Instalar Apache e módulos do sistema
RUN apt-get -qq install apache2 apache2-utils libapache2-mod-fcgid > /dev/null
RUN a2enmod rewrite

# Instalar PHP-FPM e os módulos necessários para GLPI
RUN apt-get -qq install php php-fpm php-curl php-gd php-intl php-mysql php-xml \
    php-bz2 php-phar php-zip php-exif php-ldap php-opcache php-mbstring > /dev/null

# Configurar Apache para utilizar PHP-FPM
RUN a2enmod proxy_fcgi setenvif && a2enconf php8.3-fpm

# Limpar cache de pacotes para economizar espaço
RUN apt-get -qq clean > /dev/null && rm -rf /var/lib/apt/lists/*

# Não precisa de CMD ou EXPOSE nesta imagem
