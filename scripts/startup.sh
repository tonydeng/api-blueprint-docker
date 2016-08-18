#!/bin/bash

nginx

drakov -f "/opt/api-blueprint/*.md" --public &

node /usr/local/bin/webhook.js
