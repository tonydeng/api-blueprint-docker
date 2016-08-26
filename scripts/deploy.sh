
cd /opt/api-blueprint
# build api document
find . -name "*.apib" | sed 's/.apib//' | xargs -i -t aglio -i {}.apib `echo $aglio` -o {}.html
rm -rf /usr/share/nginx/html/*
cp -R *.html /usr/share/nginx/html/

# restart drakov
pkill -9 drakov
sleep 1
drakov -f "/opt/api-blueprint/*.apib" --public &
