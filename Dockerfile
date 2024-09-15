# Usar a imagem base do Ubuntu 24.10 no ECR público
FROM public.ecr.aws/ubuntu/ubuntu:24.10

# Atualizar pacotes
RUN apt-get update

# Instalar Apache e módulos do sistema
RUN apt-get install -y apache2 apache2-utils

# Instalar PHP e módulos necessários para o GLPI
RUN apt-get install -y php libapache2-mod-php php-mysql php-xml php-mbstring \
    php-curl php-gd php-zip php-apcu php-json php-bcmath php-intl php-soap \
    php-ldap php-imagick php-cli php-opcache php-imap

# Configurar Apache para permitir 'AllowOverride All' e ajustes de permissão de diretório
RUN echo "<Directory /var/www/html>\
    Options Indexes FollowSymLinks\
    AllowOverride All\
    Require all granted\
    </Directory>" > /etc/apache2/sites-available/000-default.conf

# Habilitar módulos do Apache necessários para funcionamento do GLPI
RUN a2enmod rewrite

# Limpar cache de pacotes para economizar espaço
RUN apt-get clean

# Esta imagem não será executada diretamente, então não precisa de CMD ou EXPOSE.
