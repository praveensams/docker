
docker-compose up -d

sleep 4
docker exec -it nodejs bash -c "pm2 start server.js"


