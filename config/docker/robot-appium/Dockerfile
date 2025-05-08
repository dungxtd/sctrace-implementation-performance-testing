FROM marketsquare/robotframework-browser:latest

USER root
# Install dependencies
RUN apt-get update && apt-get install -y \
    curl unzip openjdk-11-jdk android-sdk-platform-tools \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Set environment variables for Java and Android
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV ANDROID_HOME=/usr/lib/android-sdk
ENV PATH="$PATH:/usr/lib/android-sdk/platform-tools"

# Install Node.js and Appium
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - \
    && apt-get install -y nodejs \
    && npm install -g appium \
    && appium driver install uiautomator2

# Verify tools
RUN java -version && adb version && appium -v && appium driver list

# Switch to pwuser for the remaining operations
USER pwuser

# Create venv and active it
RUN python3 -m venv /home/pwuser/.venv
ENV PATH="/home/pwuser/.venv/bin:$PATH"

# Upgrade pip and wheel for the user
RUN pip3 install --no-cache-dir --upgrade pip wheel uv

# Install RobotFramework and Browser library
RUN uv pip install --no-cache-dir --upgrade robotframework robotframework-browser==19.5.0

# Initialize Browser library without browsers binaries
RUN python3 -m Browser.entry init --skip-browsers

WORKDIR /home/pwuser
# Expose Appium port
EXPOSE 4723

CMD ["bash"]