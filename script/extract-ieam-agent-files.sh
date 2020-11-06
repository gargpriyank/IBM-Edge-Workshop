#! /bin/bash

# Extract the IEAM agent package
tar -zxvf ../../$IEAM_PACKAGE_FILE_NAME -C ../../ \
&& { cd ../../*/tools || { echo "Directory tools does not exist."; exit; } }
ibm-edge-auth
# Validate the installation stats
./service_healthcheck.sh