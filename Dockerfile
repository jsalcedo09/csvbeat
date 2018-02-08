FROM alpine

# Update curl
RUN apk --update add curl

# Download analytics beat
RUN ( curl -L https://github.com/sameer1703/csv-wsuitemetric-beat/releases/download/v1.0.1/csvbeat-5.2.1-SNAPSHOT-linux-x86_64.tar.gz -o /tmp/csvbeat.tar.gz  && cd /tmp/ && tar -xvf csvbeat.tar.gz  && mv /tmp/csvbeat-5.2.1-SNAPSHOT-linux-x86_64 /usr/bin/csvbeat && mkdir /etc/csvbeat && mv /usr/bin/csvbeat/csvbeat.yml /etc/csvbeat/csvbeat.yml && rm -rf /tmp/* )
COPY wsuiteCA.crt /etc/efsbeat/ssl/wsuiteCA.crt
COPY wsuite.insight.crt /etc/efsbeat/ssl/wsuite.insight.crt
COPY wsuite.insight.key /etc/efsbeat/ssl/wsuite.insight.key

CMD ["/usr/bin/csvbeat/csvbeat", "-c", "/etc/csvbeat/csvbeat.yml", "-e"]


