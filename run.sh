docker build -t taurus-selenium-jmeter:latest -f ./config/docker/sele-jmeter/Dockerfile .

docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-jmeter:latest \
  tests/web/taurus/web_performance.yaml

docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-jmeter:latest \
  tests/api/jmeter/simple-assert.yml