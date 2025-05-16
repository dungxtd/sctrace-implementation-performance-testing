FROM blazemeter/taurus

ENV JMETER_HOME=/opt/apache-jmeter
ENV PATH=$JMETER_HOME/bin:$PATH

# Install OpenJDK 11, curl, jq, unzip
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk curl jq unzip && \
    update-alternatives --set java /usr/lib/jvm/java-11-openjdk-amd64/bin/java

# Get latest JMeter version from GitHub, download and install
RUN JMETER_VERSION=5.6.3 && \
    echo "Installing JMeter version: ${JMETER_VERSION}" && \
    curl -L "https://downloads.apache.org/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.zip" -o /tmp/jmeter.zip && \
    unzip /tmp/jmeter.zip -d /opt && \
    mv /opt/apache-jmeter-${JMETER_VERSION} ${JMETER_HOME} && \
    rm /tmp/jmeter.zip && \
    chmod -R +x ${JMETER_HOME}/bin && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Verify installations
RUN java -version && jmeter --version