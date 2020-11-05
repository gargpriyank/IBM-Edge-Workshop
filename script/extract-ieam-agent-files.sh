#! /bin/bash

export IEAM_PACKAGE_FILE_NAME_NO_EXT=${IEAM_PACKAGE_FILE_NAME%%.*}

tar -zxvf ../../$IEAM_PACKAGE_FILE_NAME \
&& { cd $IEAM_PACKAGE_FILE_NAME_NO_EXT/tools || { echo "Directory ${IEAM_PACKAGE_FILE_NAME_NO_EXT}/tools does not exist."; exit; } }
