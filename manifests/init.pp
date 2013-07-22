# Python Dev
class pythondev{
	require yum
	include iptables	
	include misc
	include httpd
	include python

	# python1::install { "Python-2.7.3":
	#   version => "2.7.3"
	# }

	# python1::pip { "yolk":
	#   ensure => present,
	# }
}
include pythondev