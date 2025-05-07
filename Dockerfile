# Etapa 1: Build con Maven y Java 17
FROM maven:3.8.6-eclipse-temurin-17 as build

WORKDIR /app

# Copiar dependencias primero para aprovechar la cache si no cambian
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copiar el código fuente
COPY src ./src

# Compilar con trazas
RUN echo "📦 Compilando backend..." && \
    mvn clean package -DskipTests -X && \
    echo "✅ JAR generado correctamente en target/"

# Etapa 2: Ejecutar el JAR
FROM eclipse-temurin:17-jdk
WORKDIR /app

# Copiar el .jar generado (ajusta el nombre si cambia)
COPY --from=build /app/target/resumenes-0.0.1-SNAPSHOT.jar app.jar

# Exponer el puerto del backend
EXPOSE 8080

# Mensaje antes de arrancar
CMD echo "🚀 Iniciando ResumenesBackend en producción..." && \
    java -jar app.jar
