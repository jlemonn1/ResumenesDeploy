# Etapa de construcción
FROM maven:3.8.6-eclipse-temurin-17 as build

# Crear directorio de trabajo
WORKDIR /app

# Copiar archivos necesarios para compilar
COPY pom.xml .
COPY src ./src

# Compilar el proyecto sin tests
RUN mvn clean package -DskipTests

# Etapa de ejecución
FROM eclipse-temurin:17-jdk

# Crear directorio de trabajo
WORKDIR /app

# Copiar el .jar generado desde la etapa de build
COPY --from=build /app/target/*.jar app.jar

# Puerto que expone el backend
EXPOSE 8080

# Instrucción de ejecución
ENTRYPOINT ["java", "-jar", "app.jar"]
