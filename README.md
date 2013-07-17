Description
===========

Installs and configures rsyslog to replace sysklogd for client and/or
server use. By default, the service will be configured to log to
files on local disk. See the __Recipes__ and __Examples__ sections
for other uses.

Usage
=====

apply "rsyslog::server" role to the desired rsyslog-server and "rsyslog::client" to every client 