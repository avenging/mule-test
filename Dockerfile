FROM openjdk:7
RUN cd /opt && \
wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/4.1.0/mule-standalone-4.1.0.tar.gz && \
tar xvzf mule-standalone-4.1.0.tar.gz && \
rm mule-standalone-4.1.0.tar.gz && \
ln -s /opt/mule-standalone-4.1.0 /opt/mule && \
chgrp -R 0 /opt/mule-standalone-4.1.0 && \
chmod -R g=u /opt/mule-standalone-4.1.0

COPY hello-mule.jar /opt/mule/apps

CMD [ "/opt/mule/bin/mule" ]
