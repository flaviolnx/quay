#!/bin/bash

#Create necessary secrets for quay deployment.

echo "you are logged as $(oc whoami), this user must be cluster admin"

read -p 'Enter quay database password (must have 8 characters): ' DBPASS
read -p 'Enter quay database root password (must have 8 characters): ' DBROOTPASS
read -p 'Enter quay redis password (must have 8 characters)' REDISPASS
read -p 'Enter quay config password (must have 8 characters)' QUAYCONFIGPASS
read -p 'Enter quay superuser password (must have 8 characters)' QUAYSUPASS
read -p 'Enter quay superuser email' QUAYSUMAIL

# create quay-enterprise project
oc new-project quay-enterprise
oc project quay-enterprise

# create Quay secrets
oc create secret generic quay-database-credential --from-literal=database-username=quay --from-literal=database-password=$DBPASS --from-literal=database-root-password=$DBROOTPASS --from-literal=database-name=quay-enterprise
oc create secret generic quay-super-user --from-literal=superuser-username=quayadmin --from-literal=superuser-password=$QUAYSUPASS --from-literal=superuser-email=$QUAYSUMAIL
oc create secret generic quay-config-app --from-literal=config-app-password=$QUAYCONFIGPASS
oc create secret generic quay-redis-password --from-literal=password=$REDISPASS
