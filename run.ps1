# Build the Docker image

docker build -t taurus-selenium-jmeter:latest -f ./config/docker/sele-jmeter/Dockerfile .

# Run the first container for the web performance test
docker run -it `
  --platform linux/amd64 `
  -v "${PWD}/tests:/bzt-configs/tests" `
  -v "${PWD}/results:/bzt-configs/results" `
  taurus-selenium-jmeter:latest `
  tests/web/taurus/web_performance.yaml

# Run the second container for the API JMeter test
docker run -it `
  --platform linux/amd64 `
  -v "${PWD}/tests:/bzt-configs/tests" `
  -v "${PWD}/results:/bzt-configs/results" `
  taurus-selenium-jmeter:latest `
  tests/api/jmeter/simple-assert.yml
