UCOMMAND="use devsail ; db.createUser({user:'Sail_Dev_App', pwd:'Yhnm78IU45!**gh6', roles:[{role:'readWrite', db:'devsail'}]})"
MCOMMAND="db.createUser({user: 'admin',pwd: 'Pe@rson@123',roles:[{role: 'root',db: 'admin'}]})"
echo $MCOMMAND
mongo --port 27017 admin --eval "$UCOMMAND"
mongo --port 27017 admin --eval "$MCOMMAND"

