docker pull praveensams/node && docker pull praveensams/nginx 
docker run  -v /AZVOL:/AZVOL --name "nodejs" -t -d praveensams/node bash
sleep 2
docker exec -d nodejs pm2 start server.js
sleep 2
cat /opt/nse.conf  | sed  's/proxy_pass http:\/\/.*:8080;/proxy_pass http:\/\/nodejs:4001;/g' | tee  /opt/default.conf
sleep 2
docker run  --name "nginx" --link nodejs:nodejs -p 80:80 -t -d praveensams/nginx bash
sleep 2
docker cp /opt/default.conf nginx:/etc/nginx/conf.d
sleep 3
docker exec -d nginx service nginx restart
sleep 3
mkdir -p /AZVOL/{mongodb2/logs,mongodb/log}
