#!/bin/bash

# generate database
psql -U postgres -f ./database/boxes-schema.sql
# connect & populate
psql -U postgres -d boxes -f ./database/boxes-population.sql
