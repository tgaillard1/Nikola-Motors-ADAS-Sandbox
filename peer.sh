#!/usr/bin/env bash

read -p "Enter a Project ID: " project_id

gcloud compute networks peerings create peer-data-fusion-with-nikola-sandbox-network \
    --network=nikola-sandbox-network \
    --peer-project=$project_id \
    --peer-network=adas-data-fusion-network
