# JDT Analyzer - .NET 8 + OpenJDK 22 Container

This example demonstrates a .NET 8 Hello World application containerized with:
- Java OpenJDK 22 runtime
- Bash entrypoint
- Upload endpoint to receive JDK files

## Build

docker build -t jdt-analyzer-net8 .

## Run

docker run -p 8080:8080 jdt-analyzer-net8

## Upload test

curl -F "file=@sample.jdk" http://localhost:8080/upload