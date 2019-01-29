## Prerequisites
You need to install docker in your computer

## Installation
First you need to change `MACHINE_FQDN` variable in `.env` file:
```bash
MACHINE_FQDN=domain.loc
...
```

Than edit /etc/hosts file according to your `MACHINE_FQDN` setting:
```text
...
127.0.0.1 domain.loc
```

Generate sertificates in `secrets` folder:
```bash
$ cd ./secrets
$ openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -keyout portus.key -out portus.crt
```

Run docker-compose in the root folder:
```bash
$ docker-compose up -d
``` 

A bit wait and then you can visit login page `https://domain.loc` in your browser. 
Create first admin user. And than create first registry:
- Name: name of your registry
- Hostname: domain.loc
- Use SSL: true

Than click on button "Create"

After that you can push your images

```bash
$ docker login domain.loc
$ docker push domain.loc/nginx
```

Ta-daaaaam)

## Garbage collector

By default script runs every day at 2:00 am

For execute garbage-collector script manually, just send HUP signal
to your registry container:
```bash
$ docker-compose kill -s HUP registry
```