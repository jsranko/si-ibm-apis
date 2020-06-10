#!/bin/bash

INSTALL_DIR=/QIBM/ProdData/OS/WebServices/bin

qsh ${INSTALL_DIR}/createWebServicesServer.sh -server WSSSIIIA -startingPort 16787 -userid QWSERVICE -version '*CURRENT' -printErrorDetails && \
qsh ${INSTALL_DIR}/startWebServicesServer.sh -server WSSSIIIA -printErrorDetails
