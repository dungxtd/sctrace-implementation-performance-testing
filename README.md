# Docker Setup and Execution Guide

This guide provides instructions on how to build and run Docker containers for web performance, API JMeter tests, and mobile testing using Docker Compose.

## Prerequisites

- Ensure Docker and Docker Compose are installed on your system. You can download them from:
  - [Docker Desktop](https://www.docker.com/products/docker-desktop) (includes Docker Compose)
  - [Docker Compose](https://docs.docker.com/compose/install/) (standalone installation)

## Using Docker Compose

The project includes a `docker-compose.yaml` file that defines all the necessary services. You can build and run the services using the following commands:

### Building Services

```bash
# Build all services
docker-compose build

# Build specific service
docker-compose build taurus-selenium-jmeter
docker-compose build robot-appium
```

### Running Services

#### Selenium JMeter Tests

```bash
# Run the taurus-selenium-jmeter service
docker-compose run taurus-selenium-jmeter tests/web/taurus/web_performance.yaml

# Run API JMeter tests
docker-compose run taurus-selenium-jmeter tests/api/jmeter/simple-assert.yml
```

#### Mobile Testing with Appium

```bash
# Run the robot-appium service
docker-compose run robot-appium robot tests/mobile/robot/test.robot
```

### Stopping Services

```bash
# Stop all running services
docker-compose down
```

## Notes

- Ensure that the paths to the test and result directories are correctly set in the commands.
- The Docker images must be built before running the containers.
- When using Docker Compose, environment variables and volume mappings are automatically handled as defined in the `docker-compose.yaml` file.