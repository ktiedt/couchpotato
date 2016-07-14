#!/bin/bash
umask 000

chown -R ktiedt:ktiedt /opt/couchpotato /config

exec /sbin/setuser ktiedt python /opt/couchpotato/CouchPotato.py --config_file=/config/config.ini --data_dir=/config/data
