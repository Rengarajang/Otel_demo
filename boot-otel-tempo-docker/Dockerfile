FROM rengarajang/openjdk8-promtail:latest

ENV OTEL_AGENT_VERSION=0.16.1 \
    OTEL_AGENT_JAR_FILE=opentelemetry-javaagent-all-0.17.0.jar \
    APP_HOME=/app/bin \
    APP_LOG=/app/logs \
    MIN_HEAP_SIZE="40M" MAX_HEAP_SIZE="512M" THREADSTACK_SIZE="228k" \
    JAVA_GC_ARGS="-XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -XX:+UseSerialGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90" \
    JAVA_OPTS="-server -Duser.timezone=America/Chicago -Djava.security.egd=file:/dev/./urandom -XX:CompressedClassSpaceSize=64m -XX:MaxMetaspaceSize=256m" \
    JAVA_DIAG_ARGS="" \
    JAVA_OPTS_APPEND=""

RUN mkdir -p ${APP_HOME} && mkdir -p ${APP_LOG}

COPY ./scripts/start-app.sh ${APP_HOME}/
COPY ./agent/${OTEL_JAR_FILE} ${APP_HOME}/

#USER root
#RUN chown -R 1001:1001 ${APP_HOME}
#RUN ["chmod", "+x", "/app/bin/start-app.sh"]

#USER 1001

#ENTRYPOINT [ "/app/bin/start-app.sh" ]

CMD ["sh", "/app/bin/start-app.sh"]
