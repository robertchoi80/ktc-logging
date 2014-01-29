name              "ktc-logging"
maintainer        "Robert Choi"
license           "Apache 2.0"
description       "TLC for logging"
version '1.0.22'

depends "elasticsearch"
depends "kibana", ">= 1.2.0"
depends "ktc-rsyslog"
depends "logstash"
depends "ktc-monitor"
depends "openstack-common"
