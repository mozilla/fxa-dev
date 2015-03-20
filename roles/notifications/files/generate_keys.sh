#!/bin/bash

openssl genrsa -out /data/fxa-notification-server/secret.pem 2048
openssl rsa -in /data/fxa-notification-server/secret.pem -pubout -out /data/fxa-notification-server/public.pem
