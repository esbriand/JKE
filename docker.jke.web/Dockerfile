# FROM registry.ng.bluemix.net/dtr_ucd_demo1/jke.web:latest
FROM registry.ng.bluemix.net/dtr_ucd_demo1/websphere-liberty:latest
EXPOSE 9080
RUN mkdir -p /tmp/staging
ADD jke /tmp/staging
RUN cp /tmp/staging/jke.war /opt/ibm/wlp/usr/servers/defaultServer/dropins/.
ENV LICENSE accept