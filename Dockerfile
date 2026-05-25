# Stage 1: Build WAR using Gradle
FROM gradle:8.8-jdk21 AS builder
WORKDIR /app
COPY . .
RUN gradle clean war

# Stage 2: Run Tomcat
FROM tomcat:10.1-jdk21
RUN rm -rf /usr/local/tomcat/webapps/*
COPY --from=builder /app/build/libs/ROOT.war /usr/local/tomcat/webapps/ROOT.war
EXPOSE 8080
CMD ["catalina.sh", "run"]