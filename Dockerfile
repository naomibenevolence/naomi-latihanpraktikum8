version: '3.8'
services:
    app:
        build:
            context:
            dockerfile: Dockerfile
            image: laravel-app
            container_name: laravel_app
            restart: unless-stopped
            volumes:
                -.:/var/www
            networks:
                - laravel

db:
    Image: mysql:8.0
    container_name: laravel_db
    restart: unless-stopped
    environment:
        MYSQL ROOT PASSWORD: password
        MYSQL DATABASE: laravel
        MYSQL USER: laraveluser
        MYSQL PASSWORD: laravelpassword
        volumes:
            - dbdata:/var/lib/mysql
        networks:
            - laravel
        ports:
            -"3306:3306"

webserver:
    image: nginx:alpine
    container_name: laravel_web
    restart: unless-stopped
    ports:
        - "8000:80"
    volumes:
        - .:/var/www
        -./nginx.conf:/etc/nginx/conf.d/default.conf
    networks:
        - laravel

networks:
    laravel:
