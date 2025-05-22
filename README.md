# JDT Analyzer - .NET 8 + OpenJDK 22 Container

This example demonstrates a .NET 8 Hello World application containerized with:
- Java OpenJDK 22 runtime
- Bash entrypoint
- Upload endpoint to receive JDK files

---

## Git-Based OpenShift Deployment

### Step 1: Push to Git

Ensure your repository includes:
- Dockerfile
- run.sh
- HelloWorldApp/ source directory

Push it to GitHub, GitLab, or a private Git service.

### Step 2: Deploy from Git in OpenShift

Via Web Console:
1. Go to **Developer → +Add → From Git**
2. Enter Git repo URL (e.g., https://github.com/your-org/jdt-analyzer-poc)
3. Select build strategy: **Dockerfile**
4. Configure name, port (8080), and route exposure
5. Click **Create**

Or via CLI:

```bash
oc new-app --name=jdt-analyzer-net8 --strategy=docker --context-dir=src/HelloWorldApp https://github.com/your-org/jdt-analyzer-poc.git
oc expose svc/jdt-analyzer-net8
```

---

## Access and Upload Test

```bash
curl -F "file=@sample.jdk" http://<your-route>/upload
```

---

## Verify Java & Bash Inside the Pod

```bash
oc get pods
oc rsh <your-pod-name>
java -version
bash --version
ls /app/analyzed-jdts
```

---

## Project Structure

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

## Notes

- Java OpenJDK 22 is installed from Adoptium (Eclipse Temurin)
- Bash is available for scripting and inspection
- /upload route handles and persists JDK uploads inside the container
