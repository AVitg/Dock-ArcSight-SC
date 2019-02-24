#!/bin/bash

/etc/init.d/arc_syslog22514 start

tail -F /opt/arcsight/connector/current/logs/agent.log
