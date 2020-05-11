#!/usr/bin/env bash
nginx
cd /data/hugo/
hugo -e prod --cleanDestinationDir --watch --forceSyncStatic --noChmod 
