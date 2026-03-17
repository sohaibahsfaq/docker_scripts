read -p 'Instance Name: ' NAME
read -p 'Image:Tag: ' IMAGE
read -p 'Port' PORT
# making addons directory
#mkdir /root/addons/$NAME
#echo addons directory created at /root/addons/$NAME

export DB=db

echo ' '

echo 'creating database container ... Container ID:'
docker run  -d -e POSTGRES_USER=axiom -e POSTGRES_PASSWORD=axiom -e POSTGRES_DB=postgres --restart unless-stopped --name $NAME$DB    postgres:10
#docker run  -d -e POSTGRES_USER=odoo -e POSTGRES_PASSWORD=odoo  --restart unless-stopped --name $NAME$DB    postgres:9.4

echo 'creating app container ... Container ID:'
docker run  -d -v /root/addons/$NAME:/mnt/extra-addons -p $PORT:8069 --restart unless-stopped  --name $NAME --link $NAME$DB:db -t $IMAGE

echo ' '
echo Script Run. 


