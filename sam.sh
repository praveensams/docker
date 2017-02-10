rm -rvf /tmp/{nginx,node}.log
status()
        {

        docker cp process.sh ${s}:/home
        sleep 2
        docker exec -d ${s} bash /home/process.sh
        sleep 2

        }

docker run  -v /AZVOL:/AZVOL --name "nodejs" -t -d praveensam/node1 bash
sleep 2
docker exec -d nodejs pm2 start server.js
sleep 2
sleep 2
cat nse.conf  | sed  's/proxy_pass http:\/\/.*:8080;/proxy_pass http:\/\/nodejs:4001;/g' | tee  default.conf
sleep 2
#status
sleep 2
docker cp nodejs:/tmp/process.log /tmp/node.log
sleep 2
unset s
docker run -v /mnt:/var/log/nginx --name "nginx" --link nodejs:nodejs -p 80:80 -t -d praveensam/nginx bash
sleep 2
sleep 2
docker cp default.conf nginx:/etc/nginx/conf.d
sleep 3
docker exec -d nginx service nginx restart
sleep 3
#status
sleep 2
docker cp nginx:/tmp/process.log /tmp/nginx.log
mkdir -p /AZVOL/{mongodb2/logs,mongodb/log}
