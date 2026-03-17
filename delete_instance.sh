read -p 'Instance name: ' NAME
read -p 'Delete addons folder? (y/n): ' DELDIR

# -- getting container directory
CID=$(docker inspect --format="{{.Id}}" $NAME)
# -- getting port for the container
PORT=$(docker inspect --format='{{(index (index .NetworkSettings.Ports "8069/tcp") 0).HostPort}}' $CID)

export DB='db'

echo Stopping app container: 
docker stop $NAME
echo Deleting app container: 
docker rm $NAME
echo ' '
echo Stopping db container:  
docker stop $NAME$DB
echo Deleting db container: 
docker rm $NAME$DB
echo ' '

#removing directory 
if [[ $DELDIR =~ ^[Yy]$ ]] 
then
  echo removing directory $NAME$PORT
  rm -rf $NAME$PORT
fi 

echo ' ' 
echo 'Instance' $NAME 'deleted!' 
