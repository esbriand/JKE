# Set env for Docker native commands but deploying to Bluemix
export DOCKER_HOST=tcp://containers-api.ng.bluemix.net:8443
export DOCKER_CERT_PATH=/root/.ice/certs/containers-api.ng.bluemix.net/b01d5ffb-cdb4-4e27-ad3c-198db20921e4
export DOCKER_TLS_VERIFY=1
export COMPOSE_HTTP_TIMEOUT=120
