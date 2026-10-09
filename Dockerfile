# Purpose: This Dockerfile containerizes the static web application for SWE645 Assignment 2 using an Apache web server.
# Author: Sattu Akarsh Reddy

FROM httpd:2.4-alpine
COPY ./ /usr/local/apache2/htdocs/