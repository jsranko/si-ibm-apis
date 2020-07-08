#!/bin/bash

INSTALL_DIR=/QIBM/ProdData/OS/WebServices/bin
CONFIGURATION_FILE=

################################################################################
#
#                               Procedures.
#
################################################################################

createWebServicesServer()
{
	echo "" && echo "Der Server $1 wird gestoppt ..."
	if ! qsh ${INSTALL_DIR}/stopWebServicesServer.sh -server $1 $5 > ${LOG_FILE} 2>&1; then
		echo "" && echo "Der Server $1 könnte nicht gestoppt werden oder existiert nicht."
	else
		echo "" && echo "Der Server $1 wird geloescht ..."
		if ! qsh ${INSTALL_DIR}/deleteWebServicesServer.sh -server $1 $5> ${LOG_FILE} 2>&1; then
			echo "" && echo "Der Server $1 könnte nicht geloescht werden."
		fi
	fi
	
	echo "" && echo "Der Server $1:$2 fur User:$4 in Version:$3 wird erstellt ..."
	if ! qsh ${INSTALL_DIR}/createWebServicesServer.sh -server $1 -startingPort $2 -userid $4 -version $3 $5> ${LOG_FILE} 2>&1; then
		echo "" && echo "Der Server $1:$2 fur User:$4 in Version:$3 könnte nicht erstellt werden."
		return 1
	else
		echo "" && echo "Der Server $1 wird gestartet ..."
		if ! qsh ${INSTALL_DIR}/startWebServicesServer.sh -server $1 $5> ${LOG_FILE} 2>&1; then
			echo "" && echo "Der Server $1 könnte nicht gestartet werden."
			return 1
		fi	
	fi
}

installWebService()
{
	SERVICE_NAME=$(jq '.name' -r <<< "$2")
	SERVICE_PGM_OBJECT=$(jq '.programObject' -r <<< "$2")
	SERVICE_PCML=$(jq '.pcml' -r <<< "$2")
	if [ ${SERVICE_PCML} != "" ]; then
		SERVICE_PCML="-pcml ${SERVICE_PCML}"
	else
		SERVICE_PCML=''
	fi
	SERVICE_USER=$(jq '.userId' -r <<< "$21")
	SERVICE_FIELD_LENGTH_DETECT=$(jq '.detectFieldLengths' -r <<< "$2")
	if [ ${SERVICE_FIELD_LENGTH_DETECT} == "true" ]; then
		SERVICE_FIELD_LENGTH_DETECT='-detectFieldLengths'
	else
		SERVICE_FIELD_LENGTH_DETECT=''
	fi
	SERVICE_SERVICE_TYPE=$(jq '.serviceType' -r <<< "$2")
	SERVICE_HOST=$(jq '.host' -r <<< "$2")
	SERVICE_TARGET_NAMESPACE=$(jq '.targetNamespace' -r <<< "$2")
	if [ ${SERVICE_TARGET_NAMESPACE} != "" ]; then
		SERVICE_TARGET_NAMESPACE="-targetNamespace ${SERVICE_TARGET_NAMESPACE}"
	else
		SERVICE_TARGET_NAMESPACE=''
	fi
	SERVICE_PROPERTIES_FILE=$(jq '.propertiesFile' -r <<< "$2")
	SERVICE_LIBRARY_LIST=$(jq '.libraryList' -r <<< "$2")
	SERVICE_LIBRARY_LIST_POSITION=$(jq '.libraryListPosition' -r <<< "$2")
	SERVICE_TRANSPORT_METADATA=$(jq '.transportMetadata' -r <<< "$2")
	if [ ${SERVICE_TRANSPORT_METADATA} != "" ]; then
		SERVICE_TRANSPORT_METADATA="-transportMetadata ${SERVICE_TRANSPORT_METADATA}"
	else
		SERVICE_TRANSPORT_METADATA=''
	fi

	SERVICE_TRANSPORT_HEADERS=$(jq '.transportHeaders' -r <<< "$2")
	if [ ${SERVICE_TRANSPORT_HEADERS} != "" ]; then
		SERVICE_TRANSPORT_HEADERS="-transportHeaders ${SERVICE_TRANSPORT_HEADERS}"
	else
		SERVICE_TRANSPORT_HEADERS=''
	fi
	SERVICE_USE_PARAM_AS_ELEMENT_NAME=$(jq '.useParamNameAsElementName' -r <<< "$2")
	if [ ${SERVICE_USE_PARAM_AS_ELEMENT_NAME} == "true" ]; then
		SERVICE_USE_PARAM_AS_ELEMENT_NAME='-useParamNameAsElementName'
	else
		SERVICE_USE_PARAM_AS_ELEMENT_NAME=''
	fi
	
	echo "" && echo "Die propertiesFiles:$3 wird erstellt ..."
	for j in $(jq '.methods | keys | .[]' -r <<< "$2"); do
		methode=$(jq ".methods[${j}]" -r <<< "$2");
		createPropertiesFile "${methode}" $3;
	done
	
	echo "" && echo "Die Service ${SERVICE_NAME} (${SERVICE_PGM_OBJECT}) wird installiert ..."
	echo "	${INSTALL_DIR}/installWebService.sh -server $1 \
													-programObject ${SERVICE_PGM_OBJECT} \
													-service ${SERVICE_NAME} \												
													${SERVICE_PCML} \	
													-userid ${SERVICE_USER} \
													${SERVICE_FIELD_LENGTH_DETECT} \	
													-serviceType ${SERVICE_SERVICE_TYPE} \
													-host ${SERVICE_HOST} \
													${SERVICE_TARGET_NAMESPACE} \
													-propertiesFile $3 \
													-libraryList ${SERVICE_LIBRARY_LIST} \
													-libraryListPosition ${SERVICE_LIBRARY_LIST_POSITION} \
													${SERVICE_TRANSPORT_METADATA} \
													${SERVICE_USE_PARAM_AS_ELEMENT_NAME} \
													${SERVICE_TRANSPORT_HEADERS} \
												${SERVER_PRINT_ERROR_DETAILS}"
	if ! qsh ${INSTALL_DIR}/installWebService.sh -server $1 \
												-programObject ${SERVICE_PGM_OBJECT} \
												-service ${SERVICE_NAME} \												
												${SERVICE_PCML} \	
												-userid ${SERVICE_USER} \
												${SERVICE_FIELD_LENGTH_DETECT} \	
												-serviceType ${SERVICE_SERVICE_TYPE} \
												-host ${SERVICE_HOST} \
												${SERVICE_TARGET_NAMESPACE} \
												-propertiesFile $3 \
												-libraryList ${SERVICE_LIBRARY_LIST} \
												-libraryListPosition ${SERVICE_LIBRARY_LIST_POSITION} \
												${SERVICE_TRANSPORT_METADATA} \
												${SERVICE_USE_PARAM_AS_ELEMENT_NAME} \
												${SERVICE_TRANSPORT_HEADERS} \
												${SERVER_PRINT_ERROR_DETAILS} > ${LOG_FILE} 2>&1; then
		echo "" && echo "Die Service ${SERVICE_NAME} (${SERVICE_PGM_OBJECT}) könnte nicht installiert werden."
		return 1
fi	
	
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

loadConfiguration()
{
	echo "" && echo "Die Konfiguration-Datei:$1 wird geladen ..."
	CONFIGURATION_FILE=$(jq '.' -r $1) && echo "Die Konfiguration-Datei:$1 wurde erfolgreich geladen" || { echo "Die Konfiguration-Datei:$1 nicht gefunden!"; exit 1; }
}


################################################################################
#
#                               Main
#
################################################################################

loadConfiguration $1

SERVER_NAME=$(jq '.server.name' -r <<< "${CONFIGURATION_FILE}")
SERVER_PORT=$(jq '.server.port' -r <<< "${CONFIGURATION_FILE}")
SERVER_USER=$(jq '.server.userId' -r <<< "${CONFIGURATION_FILE}")
SERVER_VERSION=$(jq '.server.version' -r <<< "${CONFIGURATION_FILE}")
SERVER_PRINT_ERROR_DETAILS=$(jq '.server.printErrorDetails' -r <<< "${CONFIGURATION_FILE}")
if [ ${SERVER_PRINT_ERROR_DETAILS} == "true" ]; then
	SERVER_PRINT_ERROR_DETAILS='-printErrorDetails'
else
	SERVER_PRINT_ERROR_DETAILS=''
fi
PROPERTIES_FILE=/tmp/${SERVER_NAME}.propertiesFile
LOG_FILE=/tmp/${SERVER_NAME}.log

if ! createWebServicesServer ${SERVER_NAME} ${SERVER_PORT} ${SERVER_VERSION} ${SERVER_USER} ${SERVER_OPTIONS}; then
	exit 1
fi

echo "" && echo "Die Services werden installiert ..."
rm ${PROPERTIES_FILE}
for i in $(jq '.services | keys | .[]' -r <<< "${CONFIGURATION_FILE}"); do
	service=$(jq ".services[${i}]" -r <<< "${CONFIGURATION_FILE}");
	if ! installWebService ${SERVER_NAME} "${service}" ${PROPERTIES_FILE}; then
		exit 1
	fi
done





