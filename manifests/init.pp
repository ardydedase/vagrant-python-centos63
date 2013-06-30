# Puppet manifest for my PHP dev machine
class pythondev{
	require yum
	include iptables
	#include rpmforge
	include misc
	include httpd
	include python
	# include db
	# include php	
	# include phpmyadmin
}
include pythondev