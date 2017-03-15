
docker-compose up -d

sleep 4
docker exec -i nodejs bash -c "pm2 start server.js"


