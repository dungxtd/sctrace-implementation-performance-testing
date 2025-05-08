# Docker Setup and Execution Guide

This guide provides instructions on how to build and run Docker containers for web performance and API JMeter tests using the provided Dockerfiles and scripts.

## Prerequisites

- Ensure Docker is installed on your system. You can download it from [Docker's official website](https://www.docker.com/products/docker-desktop).

## Building Docker Images

Navigate to the root directory of the project where the Dockerfiles are located.

## Windows

### Building Docker Images
Run the following commands to build the Docker images:

```powershell
# Build the Selenium JMeter Docker Image
# For PowerShell
docker build -t taurus-selenium-jmeter:latest -f ./config/docker/sele-jmeter/Dockerfile .

# Build the Appium Docker Image
# For PowerShell
cd ./config/docker/appium-docker-android; docker build -t taurus-appium:latest .; cd ../../../
```

### Web Performance Test
Run the following command to start the container for web performance testing:

```powershell
# For PowerShell
docker run -it `
  --platform linux/amd64 `
  -v "${PWD}/tests:/bzt-configs/tests" `
  -v "${PWD}/results:/bzt-configs/results" `
  taurus-selenium-jmeter:latest `
  tests/web/taurus/web_performance.yaml
```

### API JMeter Test
Run the following command to start the container for API JMeter testing:

```powershell
# For PowerShell
docker run -it `
  --platform linux/amd64 `
  -v "${PWD}/tests:/bzt-configs/tests" `
  -v "${PWD}/results:/bzt-configs/results" `
  taurus-selenium-jmeter:latest `
  tests/api/jmeter/simple-assert.yml
```

## Linux/MacOS

### Building Docker Images
Run the following commands to build the Docker images:

```bash
# Build the Selenium JMeter Docker Image
# For Bash
docker build -t taurus-selenium-jmeter:latest -f ./config/docker/sele-jmeter/Dockerfile .

# Build the Appium Docker Image
# For Bash
cd ./config/docker/appium-docker-android && docker build -t taurus-appium:latest .
```

### Web Performance Test
Run the following command to start the container for web performance testing:

```bash
# For Bash
docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-jmeter:latest \
  tests/web/taurus/web_performance.yaml
```

### API JMeter Test
Run the following command to start the container for API JMeter testing:

```bash
# For Bash
docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-jmeter:latest \
  tests/api/jmeter/simple-assert.yml
```

## Notes

- Ensure that the paths to the test and result directories are correctly set in the commands.
- The Docker images must be built before running the containers.
- Adjust the volume paths if your directory structure differs.