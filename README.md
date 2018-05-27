# DOCKER BUILD

```shell
# sudo docker build -t NEW_IMAGE_NAME:php5 docker/
sudo docker build -t NEW_IMAGE_NAME:php5
```

# DOCKER START CONTAINER

```shell
docker run -it --rm \
    -p 3000:80 \
    -v {$ pwd}:/var/www/html/ \
    NEW_IMAGE_NAME:php5
```

Acessando o caminho absoluto da 'www' local

```shell
pwd
```