# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src
COPY . .
RUN dotnet publish HelloWorldApp/HelloWorldApp.csproj -c Release -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
RUN apt-get update && apt-get install -y bash wget &&     wget https://download.oracle.com/java/22/latest/jdk-22_linux-x64_bin.tar.gz &&     mkdir -p /usr/java &&     tar -xzf jdk-22_linux-x64_bin.tar.gz -C /usr/java &&     rm jdk-22_linux-x64_bin.tar.gz

ENV JAVA_HOME=/usr/java/jdk-22
ENV PATH="$JAVA_HOME/bin:$PATH"

WORKDIR /app
COPY --from=build /app .
COPY run.sh .
RUN chmod +x run.sh && mkdir -p /app/analyzed-jdts

ENTRYPOINT ["bash", "-c", "./run.sh && dotnet HelloWorldApp.dll"]