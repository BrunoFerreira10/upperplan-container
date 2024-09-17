# Usar a imagem base do Ubuntu 24.10 no ECR público
FROM public.ecr.aws/ubuntu/ubuntu:24.10

# Ajuda com instalações silenciosas
ENV DEBIAN_FRONTEND=noninteractive

# Atualizar pacotes
RUN apt-get -qq update > /dev/null

# Instalar apt-utils para evitar alertar e perda de tempo nas instalações
RUN apt-get -qq install apt-utils > /dev/null
# Instalar pre-requisitos gerais
RUN apt-get -qq install wget unzip > /dev/null

# Instalar Apache e módulos do sistema
RUN apt-get -qq install apache2 apache2-utils > /dev/null
# Habilitar módulos do Apache necessários para funcionamento do GLPI
RUN a2enmod rewrite

# Instalar PHP e módulos obrigatorios para o GLPI
RUN apt-get -qq install php php-curl php-gd php-intl php-mysql php-xml > /dev/null
# Instalar módulos php opcionais para o GLPI
RUN apt-get -qq install php-bz2 php-phar php-zip php-exif php-ldap php-opcache \
  php-mbstring > /dev/null

# Versão original
# RUN apt-get -qq install php libapache2-mod-php php-mysql php-xml php-mbstring \
#   php-curl php-gd php-zip php-apcu php-json php-bcmath php-intl php-soap \
#   php-ldap php-imagick php-cli php-opcache php-imap php-bz2 php-exif \
#   php-tokenizer php-sockets php-xmlrpc php-ftp > /dev/null  

# Instalar cloudwatch agent
RUN wget -nv  https://s3.amazonaws.com/amazoncloudwatch-agent/ubuntu/amd64/latest/amazon-cloudwatch-agent.deb
RUN dpkg -i -E ./amazon-cloudwatch-agent.deb > /dev/null
RUN rm -f ./amazon-cloudwatch-agent.deb

# Limpar cache de pacotes para economizar espaço
RUN apt-get -qq clean > /dev/null
RUN rm -rf /var/lib/apt/lists/*

# Verificar depois a limpeza de credenciais
# https://docs.docker.com/engine/reference/commandline/login/#credentials-store

# Esta imagem não será executada diretamente, então não precisa de CMD ou EXPOSE.
