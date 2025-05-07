docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-chrome \
  tests/web/taurus/web_performance.yaml

docker run -it \
  --platform linux/amd64 \
  -v ./tests:/bzt-configs/tests \
  -v ./results:/bzt-configs/results \
  taurus-selenium-chrome \
  tests/api/jmeter/simple-assert.yml