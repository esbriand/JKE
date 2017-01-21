version: '2'

services:
   db:
     image: registry.ng.bluemix.net/dtr_ucd_demo1/jke.db:@BUILD_NUMBER@
     container_name: jkebanking_db_@BUILD_NUMBER@
     restart: always

   web:
     depends_on:
       - db
     image: registry.ng.bluemix.net/dtr_ucd_demo1/jke.web:@BUILD_NUMBER@
     container_name: jkebanking_web_@BUILD_NUMBER@
     links:
       - db
     ports:
       - "9080:9080"
     restart: always
