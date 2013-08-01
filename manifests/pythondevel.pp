class pythondevel {
    require python
    $easy_install = "/usr/local/bin/easy_install-2.7"
    $env_folder = ".venv"

    package { "python-devel":
    	ensure => present
    }

    package { "libxml2-devel.x86_64":
    	ensure  => present          
    }

    package { "libxslt-devel.x86_64":
    	ensure  => present          
    }

    package { "mod_wsgi.x86_64":
        ensure  => present          
    }
    
    # pyodbc dependencies
    package { "openser-unixodbc.x86_64":
    	  ensure  => present          
    }
    package { "opensips-unixodbc.x86_64":
    	  ensure  => present    
    }
    package { "unixODBC-devel.x86_64":
    	ensure  => present          
    }
    package { "unixODBC.x86_64":
    	ensure  => present          
    }

    # PyQT Dependecies
    package { "PyQt4":
        ensure  => present          
    }    
    package { "libXext-devel.x86_64":
    	ensure  => present          
    }
    package { "PyQt4.x86_64":
    	ensure  => present          
    }    
    package { "PyQt4-webkit-devel.x86_64":
    	ensure  => present          
    }

    file { "/home/vagrant/bin":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/bin"
    }

    file { "/home/vagrant/bin/virtualenv-auto-activate.sh":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/bin/virtualenv-auto-activate.sh"
        #, before => [Exec["dos2unix"]]
    }

    # .bashrc to run virtualenv-auto-activate.sh during login
    file { "/home/vagrant/.bashrc":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/dotfiles/.bashrc"
    }

    # setup the virtualenv
    exec { "virtualenv-install":
        command => "${easy_install} virtualenv"       
    }
    
    exec { "virtualenv-create":
        command => "/usr/local/bin/virtualenv-2.7 --distribute ${env_folder}"
      , cwd => "/home/vagrant"
      , user   => "vagrant"
      , require => [Exec["virtualenv-install"]]
      , returns => [0, 1, 2]
    }

    exec { "virtualenv-activate":
        command => "/bin/bash -c 'source ${env_folder}/bin/activate'"
      , cwd => "/home/vagrant"
      , path => "/home/vagrant"
      , user   => "vagrant"
      , require => [Exec["virtualenv-create"]]
      , returns => [0, 1]
    }
}