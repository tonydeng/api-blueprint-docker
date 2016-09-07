# update api blueprint documet
if [ -d /opt/api-blueprint ]
then
    cd /opt/api-blueprint

    if [[ -z $repository ]]; then
        git checkout -f
        git clean -f
        git pull
    fi

else
        git clone $repository /opt/api-blueprint
        cd /opt/api-blueprint
fi

# convert tab and space
sed -i 's/\t/\ \ /g' *.apib
chmod 644 *.apib

# build api document
find . -name "*.apib" | sed 's/.apib//'|xargs -i -t aglio -i {}.apib `echo $aglio` -o {}.html
rm -rf /usr/share/nginx/html/*
cp -R *.html /usr/share/nginx/html/

# restart drakov
pkill -9 drakov
sleep 1
drakov -f "/opt/api-blueprint/*.apib" --public &
