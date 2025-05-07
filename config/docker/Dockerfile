FROM python:3.9-slim

# Install necessary dependencies
RUN pip install selenium bzt requests

# Copy scripts and configurations
COPY ./tests /tests
COPY ./config /config

# Install ChromeDriver for Selenium
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && wget https://chromedriver.storage.googleapis.com/113.0.5672.63/chromedriver_linux64.zip \
    && unzip chromedriver_linux64.zip \
    && mv chromedriver /usr/local/bin/ \
    && chmod +x /usr/local/bin/chromedriver \
    && rm chromedriver_linux64.zip

# Set working directory
WORKDIR /tests

# Run the tests
CMD ["bzt", "web_performance.yaml"]

