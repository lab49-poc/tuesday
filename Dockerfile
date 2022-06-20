FROM openjdk:11-alpine
ENTRYPOINT ["/usr/bin/tuesday.sh"]

COPY tuesday.sh /usr/bin/tuesday.sh
COPY target/tuesday.jar /usr/share/tuesday/tuesday.jar
