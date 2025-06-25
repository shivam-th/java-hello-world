[33mcommit d2a0b378a74e9d4460dfe94795577e5d6e689df3[m[33m ([m[1;36mHEAD[m[33m -> [m[1;32mmain[m[33m, [m[1;31morigin/main[m[33m)[m
Author: shivam <shivamthakur0567@gmail.com>
Date:   Wed Jun 25 01:14:40 2025 +0530

    Push local code

[1mdiff --git a/Dockerfile b/Dockerfile[m
[1mnew file mode 100644[m
[1mindex 0000000..b9c63a0[m
[1m--- /dev/null[m
[1m+++ b/Dockerfile[m
[36m@@ -0,0 +1,29 @@[m
[32m+[m[32m# Use maven image to build the application[m
[32m+[m[32mFROM maven:3.8.5-openjdk-17 AS builder[m
[32m+[m
[32m+[m[32m# Set the working directory[m
[32m+[m[32mWORKDIR /app[m
[32m+[m
[32m+[m[32m# Copy the source code[m
[32m+[m[32mCOPY . .[m
[32m+[m
[32m+[m[32m# Build the application[m
[32m+[m[32mRUN mvn clean package -DskipTests[m
[32m+[m
[32m+[m[32m##################################################[m
[32m+[m
[32m+[m[32m# Use a JDK image to run the application[m
[32m+[m[32mFROM openjdk:17-jdk-slim[m
[32m+[m
[32m+[m[32m# Set the working directory[m
[32m+[m[32mWORKDIR /app[m
[32m+[m
[32m+[m[32m# copy build file from stage1[m
[32m+[m[32mCOPY --from=builder /app/target/*.jar app.jar[m
[32m+[m
[32m+[m[32m# Expose the port[m
[32m+[m[32mEXPOSE 8080[m
[32m+[m
[32m+[m[32m# Run the application[m
[32m+[m[32mENTRYPOINT ["java", "-jar", "app.jar"][m
[32m+[m
[1mdiff --git a/k8s/deployment.yaml b/k8s/deployment.yaml[m
[1mnew file mode 100644[m
[1mindex 0000000..ba4bd4b[m
[1m--- /dev/null[m
[1m+++ b/k8s/deployment.yaml[m
[36m@@ -0,0 +1,19 @@[m
[32m+[m[32mapiVersion: apps/v1[m
[32m+[m[32mkind: Deployment[m
[32m+[m[32mmetadata:[m
[32m+[m[32m  name: java-app-deployment[m
[32m+[m[32mspec:[m
[32m+[m[32m  replicas: 2[m
[32m+[m[32m  selector:[m
[32m+[m[32m    matchLabels:[m
[32m+[m[32m      app: java-app[m
[32m+[m[32m  template:[m
[32m+[m[32m    metadata:[m
[32m+[m[32m      labels:[m
[32m+[m[32m        app: java-app[m
[32m+[m[32m    spec:[m
[32m+[m[32m      containers:[m
[32m+[m[32m      - name: java-app[m
[32m+[m[32m        image: 471112745159.dkr.ecr.us-east-1.amazonaws.com/my-java-app:latest[m
[32m+[m[32m        ports:[m
[32m+[m[32m        - containerPort: 8080[m
[1mdiff --git a/k8s/service.yaml b/k8s/service.yaml[m
[1mnew file mode 100644[m
[1mindex 0000000..8362ee5[m
[1m--- /dev/null[m
[1m+++ b/k8s/service.yaml[m
[36m@@ -0,0 +1,11 @@[m
[32m+[m[32mapiVersion: v1[m
[32m+[m[32mkind: Service[m
[32m+[m[32mmetadata:[m
[32m+[m[32m  name: java-app-service[m
[32m+[m[32mspec:[m
[32m+[m[32m  type: LoadBalancer[m
[32m+[m[32m  selector:[m
[32m+[m[32m    app: java-app[m
[32m+[m[32m  ports:[m
[32m+[m[32m    - port: 80[m
[32m+[m[32m      targetPort: 8080[m
