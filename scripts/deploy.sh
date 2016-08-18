#!/bin/bash

# update api blueprint documet
if [ -d /opt/api-blueprint ]
then
    cd /opt/api-blueprint
    git checkout -f
    git clean -f
    git pull
else
    get clone $repostiory /opt/api-blueprint
    cd /opt/api-blueprint
fi

# build api document
find . -name "*.apib" |sed 's/.apib//'|xargs -i -t aglio -i {}.md `echo $aglio` -o {}.html
rm -rf /usr/share/nginx/html/*
cp -R *.html /usr/share/nginx/html/

# restart drakov
pkill -9 drakov
sleep 1
drakov -f "/opt/api-blueprint/*.apib" --public &
