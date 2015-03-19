#!/bin/bash
umask 000

chown -R htpc:users /opt/couchpotato /config

exec /sbin/setuser htpc python /opt/couchpotato/CouchPotato.py --config_file=/config/config.ini --data_dir=/config/data
