rm -rvf /tmp/{nginx,node}.log
status()
	{
	
	docker cp process.sh ${s}:/home
	sleep 2
	docker exec -d ${s} bash /home/process.sh
	sleep 2
	
	}

docker run -v /AZVOL:/AZVOL -t -d praveensam/node bash
sleep 2
s=`docker ps -a | grep 'praveensam/node' | awk '{print $1}'`
docker exec -d ${s} pm2 start /AZVOL/dev-sailapi/server.js
sleep 2
node_ip=`docker inspect ${s} |  perl -ane 'if(/\"IPAddres+\":+\s\"(.*)\"/) {print $1}'`
sleep 2
cat nse.conf  | sed  's/proxy_pass http:\/\/.*:8080;/proxy_pass http:\/\/'${node_ip}':4001;/g' | tee  default.conf
sleep 2
status
sleep 2
docker cp ${s}:/tmp/process.log /tmp/node.log
sleep 2
unset s
docker run -v /mnt:/var/log/nginx -p 80:80 -t -d praveensam/nginx bash
sleep 2
s=`docker ps -a | grep 'praveensam/nginx' | awk '{print $1}'`
sleep 2
docker cp default.conf ${s}:/etc/nginx/conf.d
sleep 3
docker exec -d ${s} service nginx restart 
sleep 3
status
sleep 2
docker cp ${s}:/tmp/process.log /tmp/nginx.log
mkdir -p /AZVOL/{mongodb2/logs,mongodb/log}
docker run -d -v /AZVOL/mongodb2:/mongodb -v /mnt/mongodb2/logs:/mongodb/log -p 48077:27017 yudu123/mongodb328
