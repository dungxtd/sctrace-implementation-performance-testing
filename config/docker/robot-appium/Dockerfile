FROM ubuntu:focal-20250404

ENV DEBIAN_FRONTEND=noninteractive

#==================
# General Packages
#==================
RUN apt-get -qqy update && \
    apt dist-upgrade -y && \
    apt-get -qqy --no-install-recommends install \
    ca-certificates \
    curl \
    gnupg \
    libgconf-2-4 \
    libqt5webkit5 \
    openjdk-11-jdk \
    sudo \
    tzdata \
    unzip \
    wget \
    xvfb \
    zip \
    ffmpeg \
  && rm -rf /var/lib/apt/lists/*

#===============
# Set JAVA_HOME
#===============
ENV JAVA_HOME="/usr/lib/jvm/java-11-openjdk-amd64" \
    PATH=$PATH:$JAVA_HOME/bin

#===============================
# Set Timezone (UTC as default)
#===============================
ENV TZ "UTC"
RUN echo "${TZ}" > /etc/timezone \
  && dpkg-reconfigure --frontend noninteractive tzdata

#===============
# Create a user
#===============
ARG USER_PASS=secret
RUN groupadd androidusr \
         --gid 1301 \
  && useradd androidusr \
         --uid 1300 \
         --gid 1301 \
         --create-home \
         --shell /bin/bash \
  && usermod -aG sudo androidusr \
  && echo androidusr:${USER_PASS} | chpasswd \
  && echo 'androidusr ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers

WORKDIR /home/androidusr

#=====================
# Install Android SDK
#=====================
ENV SDK_VERSION=commandlinetools-linux-8512546_latest
ENV ANDROID_BUILD_TOOLS_VERSION=34.0.0
ENV ANDROID_FOLDER_NAME=cmdline-tools
ENV ANDROID_DOWNLOAD_PATH=/home/androidusr/${ANDROID_FOLDER_NAME} \
    ANDROID_HOME=/opt/android \
    ANDROID_TOOL_HOME=/opt/android/${ANDROID_FOLDER_NAME}
ENV ANDROID_ADB_SERVER_ADDRESS="host.docker.internal"

RUN wget -O tools.zip https://dl.google.com/android/repository/${SDK_VERSION}.zip && \
    unzip tools.zip && rm tools.zip && \
    chmod a+x -R ${ANDROID_DOWNLOAD_PATH} && \
    chown -R 1300:1301 ${ANDROID_DOWNLOAD_PATH} && \
    mkdir -p ${ANDROID_TOOL_HOME} && \
    mv ${ANDROID_DOWNLOAD_PATH} ${ANDROID_TOOL_HOME}/tools
ENV PATH=$PATH:${ANDROID_TOOL_HOME}/tools:${ANDROID_TOOL_HOME}/tools/bin

RUN mkdir -p ~/.android && \
    touch ~/.android/repositories.cfg && \
    echo y | sdkmanager "platform-tools" && \
    echo y | sdkmanager "build-tools;$ANDROID_BUILD_TOOLS_VERSION" && \
    mv ~/.android .android && \
    chown -R 1300:1301 .android
ENV PATH=$PATH:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools

#====================================
# Install latest nodejs, npm, appium
#====================================
ENV NODE_VERSION=22
RUN curl -sL https://deb.nodesource.com/setup_${NODE_VERSION}.x | bash && \
    apt-get -qqy install nodejs && \
    npm install -g appium --unsafe-perm=true --allow-root && \
    exit 0 && \
    npm cache clean && \
    apt-get remove --purge -y npm && \
    apt-get autoremove --purge -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    apt-get clean

#====================================================
# Fix permission issue to download e.g. chromedriver
#====================================================
RUN chown -R 1300:1301 /usr/lib/node_modules/appium

#==============
# Copy scripts
#==============
ENV SCRIPT_PATH="appium-docker-android"
ENV APP_PATH=/home/androidusr/${SCRIPT_PATH}
RUN mkdir -p ${APP_PATH}
COPY config/docker/robot-appium/*.sh \
    ${APP_PATH}
RUN chown -R 1300:1301 ${APP_PATH} && \
    chmod +x ${APP_PATH}/*.sh

#=======================
# Install Python & Robot
#=======================
RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip3 install --no-cache-dir robotframework robotframework-appiumlibrary && \
    rm -rf /var/lib/apt/lists/*

#==================
# Use created user
#==================
USER 1300:1301

#===============================
# Install basic Android drivers
#===============================
ENV APPIUM_DRIVER_ESPRESSO_VERSION="4.1.5"
ENV APPIUM_DRIVER_FLUTTER_VERSION="2.15.0"
ENV APPIUM_DRIVER_FLUTTER_INTEGRATION_VERSION="1.1.4"
ENV APPIUM_DRIVER_GECKO_VERSION="1.4.3"
ENV APPIUM_DRIVER_UIAUTOMATOR2_VERSION="4.2.3"
RUN appium driver install --source=npm appium-espresso-driver@${APPIUM_DRIVER_ESPRESSO_VERSION} && \
    appium driver install --source=npm appium-flutter-driver@${APPIUM_DRIVER_FLUTTER_VERSION} && \
    appium driver install --source=npm appium-flutter-integration-driver@${APPIUM_DRIVER_FLUTTER_INTEGRATION_VERSION} && \
    appium driver install --source=npm appium-geckodriver@${APPIUM_DRIVER_GECKO_VERSION} && \
    appium driver install --source=npm appium-uiautomator2-driver@${APPIUM_DRIVER_UIAUTOMATOR2_VERSION}

#===============
# Expose Port
#===============
EXPOSE 4723

#==============
# Start script
#==============
ENTRYPOINT ["/bin/sh", "-c", "${APP_PATH}/start.sh"]