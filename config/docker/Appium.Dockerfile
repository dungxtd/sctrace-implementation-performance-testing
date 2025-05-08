# Start from Taurus base image
FROM blazemeter/taurus

# Set environment variables to avoid prompts during install
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && \
    apt-get install -y curl unzip openjdk-11-jdk android-tools-adb && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Node.js and npm (required for Appium)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    npm install -g appium

# Add Appium Doctor to verify environment
RUN npm install -g appium-doctor

# Expose default Appium port
EXPOSE 4723