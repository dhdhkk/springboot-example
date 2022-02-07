# run_new_was.sh
#!/bin/bash
# 추가
REPOSITORY=/home/ec2-user/app/step2
PROJECT_NAME=zip



CURRENT_PORT=$(cat /home/ec2-user/service_url.inc | grep -Po '[0-9]+' | tail -1)
TARGET_PORT=0
echo "> Current port of running WAS is ${CURRENT_PORT}."

if [ ${CURRENT_PORT} -eq 8081 ]; then
  TARGET_PORT=8082
elif [ ${CURRENT_PORT} -eq 8082 ]; then
  TARGET_PORT=8081
else
  echo "> No WAS is connected to nginx"
fi

TARGET_PID=$(lsof -Fp -i TCP:${TARGET_PORT} | grep -Po 'p[0-9]+' | grep -Po '[0-9]+')

if [ ! -z ${TARGET_PID} ]; then
  echo "> Kill WAS running at ${TARGET_PORT}."
  sudo kill -15 ${TARGET_PID}
  sleep 5
fi

#nohup java -jar -Dserver.port=${TARGET_PORT} /home/ec2-user/app/step2/zip/build/libs/* > /home/ec2-user/app/step2/nohup.out 2>&1 &
#echo "> Now new WAS runs at ${TARGET_PORT}."
#exit 0

#nohup java -jar \
#        -Dserver.port=${TARGET_PORT} \
#        -Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties \
#        -Dspring.profiles.active=real \
#        /home/ec2-user/app/step2/zip/build/libs/* > /home/ec2-user/app/step2/nohup.out 2>&1 &

nohup java -jar -Dserver.port=${TARGET_PORT} -Dspring.config.location=classpath:/application.properties,classpath:/application-real.properties,/home/ec2-user/app/application-oauth.properties,/home/ec2-user/app/application-real-db.properties -Dspring.profiles.active=real /home/ec2-user/app/step2/zip/build/libs/* > /home/ec2-user/app/step2/nohup.out 2>&1 &
echo "> Now new WAS runs at ${TARGET_PORT}."
exit 0
