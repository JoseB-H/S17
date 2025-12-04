# Multi-stage Dockerfile for Spring Boot (build with Maven, run on JDK 17)
# --- BUILD - Compila la aplicación Spring Boot ---
FROM maven:3.9.4-eclipse-temurin-17 AS build
# Establece el directorio de trabajo dentro del contenedor
WORKDIR /app
# Copia los archivos del contenedor y configuración de Maven (pom.xml) para aprovechar el caché
# Copia el código fuente restante
COPY .mvn .mvn
COPY mvnw mvnw
COPY pom.xml pom.xml
COPY src src
# Asegúrese de que el contenedor sea ejecutable y compilable
RUN chmod +x mvnw && ./mvnw -B clean package -DskipTests
# --- Ejecutar etapa ---
FROM eclipse-temurin:17-jre-jammy
WORKDIR /app

# Copiar artefacto de la etapa de compilación
COPY --from=build /app/target/*.jar /app/app.jar
# Expone Puerto por defecto
EXPOSE 8080
# Permitir que Render u otras plataformas anulen las opciones de Java y PORT
ENV JAVA_OPTS=""
# Utilice el entorno PORT si se proporciona (Render establece PORT), predeterminado a 8080
ENTRYPOINT ["sh", "-c", "java $JAVA_OPTS -Dserver.port=${PORT:-8080} -jar /app/app.jar"]
