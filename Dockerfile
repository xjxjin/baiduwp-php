FROM php:8.0

# 安装必要的依赖和扩展
RUN apt-get update && \
    apt-get install -y libcurl4-openssl-dev libpq-dev git && \
    docker-php-ext-install pdo_mysql mysqli

WORKDIR /root

# 安装 Composer
RUN php -r "copy('https://install.phpcomposer.com/installer', 'composer-setup.php');" && \
    php composer-setup.php && \
    php -r "unlink('composer-setup.php');" && \
    mv composer.phar /usr/local/bin/composer

WORKDIR /app

# 复制应用代码
COPY ./ /app

RUN composer install

ENTRYPOINT php think run

# 暴露 8000 端口
EXPOSE 8000
