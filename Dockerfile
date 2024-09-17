# Usar a imagem base do Ubuntu 24.10 no ECR público
FROM public.ecr.aws/ubuntu/ubuntu:24.10

# Atualizar pacotes
RUN apt-get update && apt-get upgrade -y

# Instalar pre-requisitos gerais
RUN apt-get install -y wget unzip curl

# Instalar Apache e módulos do sistema
RUN apt-get install -y apache2 apache2-utils

# Instalar PHP e módulos necessários para o GLPI
RUN apt-get install -y php libapache2-mod-php php-mysql php-xml php-mbstring \
    php-curl php-gd php-zip php-apcu php-json php-bcmath php-intl php-soap \
    php-ldap php-imagick php-cli php-opcache php-imap php-bz2 php-exif \
    php-tokenizer php-sockets php-xmlrpc php-ftp

# Habilitar módulos do Apache necessários para funcionamento do GLPI
RUN a2enmod rewrite

# Instalar AWS CLI para acessar o SSM Parameter Store
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
RUN unzip awscliv2.zip
RUN ./aws/install
RUN rm -rf awscliv2.zip aws

# Limpar cache de pacotes para economizar espaço
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Esta imagem não será executada diretamente, então não precisa de CMD ou EXPOSE.
