# JDT Analyzer - .NET 8 + OpenJDK 22 Container

This example demonstrates a .NET 8 Hello World application containerized with:
- Java OpenJDK 22 runtime
- Bash entrypoint
- Upload endpoint to receive JDK files

---

## 🛠️ Build (Local)

```bash
docker build -t jdt-analyzer-net8 .
```

## 🚀 Run Locally

```bash
docker run -p 8080:8080 jdt-analyzer-net8
```

## 📤 Upload Test (Local)

```bash
curl -F "file=@sample.jdk" http://localhost:8080/upload
```

---

## ☁️ OpenShift Deployment

### 🧱 Start Build with Source Directory

```bash
oc new-build --name=jdt-analyzer-net8 --binary --strategy=docker
oc start-build jdt-analyzer-net8 --from-dir=. --follow
```

### 🚢 Deploy the Application

```bash
oc new-app jdt-analyzer-net8
oc expose svc/jdt-analyzer-net8
```

### 🌐 Access and Test Routes

```bash
ROUTE=$(oc get route jdt-analyzer-net8 -o jsonpath="http://{.spec.host}")
curl $ROUTE/
curl -F "file=@sample.jdk" $ROUTE/upload
```

### 🔍 Verify Java & Bash Inside the Pod

```bash
oc get pods
oc rsh <your-pod-name>
java -version
bash --version
ls /app/analyzed-jdts
```

---

## 📁 Project Structure

```
jdt-analyzer-net8-openjdk22/
├── HelloWorldApp/
│   ├── Program.cs
│   ├── Startup.cs
│   ├── HelloWorldApp.csproj
│
├── Dockerfile
├── run.sh
├── README.md
```

---

## ✅ Notes

- Java OpenJDK 22 is installed from Adoptium (Eclipse Temurin).
- Bash script verifies environment and lists uploaded JDT files.
- /upload route accepts and saves JDK-related files inside `/app/analyzed-jdts`.
