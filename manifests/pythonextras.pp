# Install python packages
class pythonextras {    
    require pythondevel
    $env_folder = ".venv"
    $pip_install = "/home/vagrant/${env_folder}/bin/pip install"
    $easy_install = "/usr/local/bin/easy_install-2.7"       

    # when you're using Windows as your host machine
    exec { "dos2unix":
        command => "/usr/bin/dos2unix virtualenv-auto-activate.sh"
      , path => "/usr/bin"  
      , cwd => "/home/vagrant/bin"
      , returns => [0]      
    }

    exec { "pip-install":
        command => "${easy_install} pip"      
    }

    exec { "phonenumbers-install":
        command => "${easy_install} phonenumbers"      
    }

    exec { "xlrd-install":
        command => "${easy_install} xlrd"      
    }

    exec { "epydoc-install":
        command => "${easy_install} epydoc"      
    }

    exec { "pycrypto-install":
        command => "${easy_install} pycrypto"      
    }

    exec { "pyqt-install":
        command => "${pip_install} PyQt"
      , returns => [1, 2]  
    }    

    exec { "wxpython-install":
        command => "${pip_install} wxPython"
      , require => [Exec['pip-install']]
      , returns => [1, 2]      
    }

    exec { "lxml-install":
        command => "${pip_install} lxml"      
      , require => [Exec['pip-install']]
    }

    exec { "pyodbc-install":
        command => "${pip_install} pyodbc"      
      , require => [Exec['pip-install']]
      , returns => [0, 2]
    }      

    exec { "pycurl-install":
        command => "${pip_install} pycurl"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }     

    exec { "silvercity-install":
        command => "${pip_install} SilverCity"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }    

    exec { "memcached-install":
        command => "${pip_install} python-memcached==1.47"      
      , require => [Exec['pip-install']]
    }

    # exec { "squaremap-install":
    #     command => "${pip_install} squaremap"      
    #   , require => [Exec['pip-install']]
    #   , returns => [1, 2]
    # }

    # exec { "runsnakerun-install":
    #     command => "${pip_install} runsnakerun"      
    #   , require => [Exec['pip-install']]
    #   , returns => [1, 2]
    # }

    exec { "couchbase-install":
        command => "${pip_install} couchbase"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }
}