FROM openjdk:7
RUN wget https://repository.mulesoft.org/nexus/content/repositories/releases/org/mule/distributions/mule-standalone/3.5.0/mule-standalone-3.5.0.tar.gz && \
cd /opt && tar xvzf ~/mule-standalone-3.5.0.tar.gz && \
echo "4a94356f7401ac8be30a992a414ca9b9 /mule-standalone-3.5.0.tar.gz" | md5sum -c && \
rm ~/mule-standalone-3.5.0.tar.gz && \
ln -s /opt/mule-standalone-3.5.0 /opt/mule && \
chgrp -R 0 /opt/mule-standalone-3.5.0 && \
chmod -R g=u /opt/mule-standalone-3.5.0

CMD [ "/opt/mule/bin/mule" ]
