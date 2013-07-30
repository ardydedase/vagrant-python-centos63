class pythondevel {

	package { "python-devel":
		ensure => present
	}

    package { "libxml2-devel.x86_64":
    	ensure  => present          
    }

    package { "libxslt-devel.x86_64":
    	ensure  => present          
    }

    package { "PyQt4":
    	ensure  => present          
    }
}