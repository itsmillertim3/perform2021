#!/bin/bash
# Function file for adding created keptn repos to a self-hosted git repository

source ./gitea-functions.sh $K8S_DOMAIN

# get Tokens for the User
getApiTokens

# create an Api Token
createApiToken

# read the Token and keep the hash in memory
readApiTokenFromFile

# create it for the passed project
createKeptnRepo $1