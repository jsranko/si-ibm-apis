#!/bin/bash

INSTALL_DIR=/QIBM/ProdData/OS/WebServices/bin
SERVER_NAME=$(jq '.server.name' -r $1)
SERVER_PORT=$(jq '.server.port' -r $1)
SERVER_USER=$(jq '.server.userId' -r $1)
SERVER_VERSION=$(jq '.server.version' -r $1)
SERVER_PRINT_ERROR_DETAILSS=$(jq '.server.printErrorDetails' -r $1)
PROPERTIES_FILE=/tmp/${SERVER_NAME}.propertiesFile

################################################################################
#
#                               Procedures.
#
################################################################################

installService()
{
	SERVICE_NAME=$(jq '.name' -r <<< "$1")
	SERVICE_PGM_OBJECT=$(jq '.programObject' -r <<< "$1")
	SERVICE_PCML=$(jq '.pcml' -r <<< "$1")
	SERVICE_USER=$(jq '.userId' -r <<< "$1")
	SERVICE_FELD_LENGTH_DETECT=$(jq '.detectFieldLengths' -r <<< "$1")
	if [ ${SERVICE_FELD_LENGTH_DETECT} == "true" ]; then
		SERVICE_FELD_LENGTH_DETECT='-detectFieldLengths'
	else
		SERVICE_FELD_LENGTH_DETECT=''
	fi
	SERVICE_SERVICE_TYPE=$(jq '.serviceType' -r <<< "$1")
	SERVICE_HOST=$(jq '.host' -r <<< "$1")
	SERVICE_TARGET_NAMESPACE=$(jq '.targetNamespace' -r <<< "$1")
	SERVICE_PROPERTIES_FILE=$(jq '.propertiesFile' -r <<< "$1")
	SERVICE_LIBRARY_LIST=$(jq '.libraryList' -r <<< "$1")
	SERVICE_LIBRARY_LIST_POSITION=$(jq '.libraryListPosition' -r <<< "$1")
	SERVICE_TRANSPORT_METADATA=$(jq '.transportMetadata' -r <<< "$1")
	SERVICE_TRANSPORT_HEADERS=$(jq '.transportHeaders' -r <<< "$1")
	SERVICE_TRANSPORT_HEADERS=$(jq '.transportHeaders' -r <<< "$1")
	SERVICE_USE_PARAM_AS_ELEMENT_NAME=$(jq '.useParamNameAsElementName' -r <<< "$1")
	if [ ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} == "true" ]; then
		SERVICE_USE_PARAM_AS_ELEMENT_NAME='-useParamNameAsElementName'
	else
		SERVICE_USE_PARAM_AS_ELEMENT_NAME=''
	fi
	
	echo "" && echo "Die propertiesFiles:$2 wird erstellt ..."
	for j in $(jq '.methods | keys | .[]' -r <<< "$1"); do
		methode=$(jq ".methods[${j}]" -r <<< "$1");
		createPropertiesFile "${methode}" $2;
	done
}

createPropertiesFile()
{
	touch $2
	entries=$(jq 'to_entries' -r <<< "$1")
	for k in $(jq '. | keys | .[]' -r <<< "${entries}"); do
		key=$(jq ".[${k}].key" -r <<< "${entries}")
		value=$(jq ".[${k}].value" -r <<< "${entries}")
		echo "${key}=${value}" >> $2
	done
	echo "" >> $2
}

################################################################################
#
#                               Main
#
################################################################################

#if [ ${SERVER_PRINT_ERROR_DETAILSS} == "true" ]; then
#	SERVER_PRINT_ERROR_DETAILSS='-printErrorDetails'
#else
#	SERVER_PRINT_ERROR_DETAILSS=''
#fi

echo "" && echo "Der Server ${SERVER_NAME} wird gestoppt ..."
#if ! qsh ${INSTALL_DIR}/stopWebServicesServer.sh -server ${SERVER_NAME} ${SERVER_OPTIONS}; then
#	echo 'E'
#fi

#echo "" && echo "Der Server ${SERVER_NAME} wird geloescht ..."
#if ! qsh ${INSTALL_DIR}/deleteWebServicesServer.sh -server ${SERVER_NAME} ${SERVER_OPTIONS}; then
#	echo "E"
#fi

#echo "" && echo "Der Server ${SERVER_NAME}:${SERVER_PORT} fur User:${SERVER_USER} in Version:${SERVER_VERSION} wird erstellt ..."
#if ! qsh ${INSTALL_DIR}/createWebServicesServer.sh -server ${SERVER_NAME} -startingPort ${SERVER_PORT} -userid ${SERVER_USER} -version ${SERVER_VERSION} ${SERVER_OPTIONS}; then
#	echo "E"
#fi

#echo "" && echo "Der Server ${SERVER_NAME} wird gestartet ..."
#if ! qsh ${INSTALL_DIR}/startWebServicesServer.sh -server ${SERVER_NAME} ${SERVER_OPTIONS}; then
#	echo "E"
#fi

echo "" && echo "Die Services werden installiert ..."
rm ${PROPERTIES_FILE}
for i in $(jq '.services | keys | .[]' -r $1); do
	service=$(jq ".services[${i}]" -r $1);
	installService "${service}" ${PROPERTIES_FILE};
done





