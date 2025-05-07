# Etapa 1: compilación con Maven + Java 17
FROM maven:3.8.6-eclipse-temurin-17 as build
WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src
RUN echo "📦 Compilando backend..." && \
    mvn clean package -DskipTests -X && \
    echo "✅ JAR generado correctamente en target/"

# Etapa 2: ejecución con Java 17 y memoria limitada
FROM eclipse-temurin:17-jdk
WORKDIR /app

COPY --from=build /app/target/*.jar app.jar

# Limitar memoria para evitar que Railway lo mate
ENTRYPOINT ["java", "-Xmx300m", "-Dlogging.level.root=DEBUG", "-jar", "app.jar"]


EXPOSE 8080

CMD echo "🚀 Iniciando ResumenesBackend en producción..."
