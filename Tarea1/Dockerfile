# ------------------------------ SQL 2019 ---------------------------------------
# Imagen de Docker Hub
FROM mcr.microsoft.com/mssql/server:2019-CU18-ubuntu-20.04 AS SQL2019

# Variables de entorno del contenedor
ENV MSSQL_SA_PASSWORD=C0ntrol1* ACCEPT_EULA=Y MSSQL_PID=Developer 

# Puerto SQL
EXPOSE 1433

# ------------------------------ MYSQL -------------------------------------------
FROM mysql:8.0.33 AS MySQL8

ENV MYSQL_ROOT_PASSWORD=C0ntrol1* 

EXPOSE 3306

# ------------------------------ POSTGRES ----------------------------------------
FROM postgres:latest AS Postgres

ENV POSTGRES_PASSWORD=C0ntrol1*

EXPOSE 5432

# ------------------------------ ORACLE ------------------------------------------
FROM oraclelinux:9 AS Oracle9

MAINTAINER A N Other jesusdan@unitec.edu

RUN sed -i -e '/^\[main\]/aproxy=http://proxy.example.com:80' /etc/yum.conf
RUN yum -y install httpd
RUN echo "HTTP server running on guest" > /var/www/html/index.html

EXPOSE 80

ENTRYPOINT /usr/sbin/httpd -D FOREGROUND