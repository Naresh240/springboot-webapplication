FROM maven as artifact
COPY . .
RUN mvn install

FROM tomcat:8.5.47-jdk8-openjdk
COPY --from=artifact ./target/mavewebappdemo-2.0.0-SNAPSHOT.war /usr/local/tomcat/webapps/sprinboot.war
