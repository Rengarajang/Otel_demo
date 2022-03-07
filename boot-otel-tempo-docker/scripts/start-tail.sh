 echo "Starting app.."
 /app/bin/start-app.sh &
 
 echo "Starting Promtail.."
 /usr/local/bin/promtail -config.file /etc/promtail-app.yaml
