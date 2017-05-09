#!/usr/bin/env bash
cd $(dirname $0)/..
csvlook -q "'" literature.csv
