# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish HelloWorldApp/HelloWorldApp.csproj -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
RUN apt-get update && apt-get install -y bash wget tar && \
    wget https://github.com/adoptium/temurin22-binaries/releases/download/jdk-22%2B36/OpenJDK22U-jdk_x64_linux_hotspot_22_36.tar.gz && \
    mkdir -p /usr/java && \
    tar -xzf OpenJDK22U-jdk_x64_linux_hotspot_22_36.tar.gz -C /usr/java && \
    rm OpenJDK22U-jdk_x64_linux_hotspot_22_36.tar.gz

ENV JAVA_HOME=/usr/java/jdk-22+36
ENV PATH="$JAVA_HOME/bin:$PATH"

WORKDIR /app
COPY --from=build /app .
COPY run.sh .
RUN chmod +x run.sh && mkdir -p /app/analyzed-jdts

ENTRYPOINT ["bash", "-c", "./run.sh && dotnet HelloWorldApp.dll"]
