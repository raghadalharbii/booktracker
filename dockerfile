FROM maven:3.8.6-openjdk-11 
ENV DB_URL=jdbc:mysql://booktracker-database.cvrmum6abwbw.us-east-1.rds.amazonaws.com:3306/booktracker 
ENV DB_PORT=3306 
ENV DB_NAME=booktracker 
ENV DB_USERNAME=root
ENV DB_PASSWORD=DevOps2022 
WORKDIR /app 
ADD pom.xml . 
RUN ["/usr/local/bin/mvn-entrypoint.sh","mvn","verify","clean","--fail-never"] 
COPY . . 
RUN mvn clean package 
EXPOSE 8080 
ENTRYPOINT ["java","-jar","target/booktracker-0.0.1-SNAPSHOT.jar"]