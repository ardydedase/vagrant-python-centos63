# Install python packages
class pythonextras {
    #require python
    require pythondevel

    $env_folder = ".venv"
    $pip_install = "/usr/local/bin/pip-2.7 install"
    $easy_install = "/usr/local/bin/easy_install-2.7"

    file { "/home/vagrant/bin":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/bin"
    }    

    file { "/home/vagrant/bin/virtualenv-auto-activate.sh":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/bin/virtualenv-auto-activate.sh"
        , before => [Exec["dos2unix"]]
    }

    file { "/home/vagrant/.bashrc":
          replace => true
        , ensure  => present
        , source  => "/vagrant/files/dotfiles/.bashrc"
    }    

    # when you're using Windows as your host machine
    exec { "dos2unix":
        command => "/usr/bin/dos2unix virtualenv-auto-activate.sh"
      , path => "/usr/bin"  
      , cwd => "/home/vagrant/bin"
      , returns => [0]      
    }

    exec { "virtualenv-install":
        command => "${easy_install} virtualenv"       
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

    exec { "pyqt-install":
        command => "${easy_install} PyQt"
    }

    # exec { "pywin32-install":
    #     command => "${easy_install} pywin32"      
    # }

    exec { "pycrypto-install":
        command => "${easy_install} pycrypto"      
    }

    exec { "wxpython-install":
        command => "${pip_install} wxPython"
      , require => [Exec['pip-install']]      
    }

    exec { "lxml-install":
        command => "${pip_install} lxml"      
      , require => [Exec['pip-install']]
    }

    exec { "pyodbc-install":
        command => "${pip_install} pyodbc"      
      , require => [Exec['pip-install']]
    }      

    exec { "pycurl-install":
        command => "${pip_install} pycurl"      
      , require => [Exec['pip-install']]
    }     

    exec { "silvercity-install":
        command => "${pip_install} SilverCity"      
      , require => [Exec['pip-install']]
    }    

    exec { "memcached-install":
        command => "${pip_install} python-memcached==1.47"      
      , require => [Exec['pip-install']]
    }

    exec { "squaremap-install":
        command => "${pip_install} squaremap"      
      , require => [Exec['pip-install']]
    }

    exec { "runsnakerun-install":
        command => "${pip_install} runsnakerun"      
      , require => [Exec['pip-install']]
    }

    exec { "couchbase-install":
        command => "${pip_install} couchbase"      
      , require => [Exec['pip-install']]
    }      

    # Not required.
    exec { "virtualenv-create":
        command => "/usr/local/bin/virtualenv-2.7 --distribute ${env_folder}"
      , cwd => "/home/vagrant"
      , user   => "vagrant"
      , require => [Exec["virtualenv-install"]]
      , returns => [0, 1]
    }

    exec { "virtualenv-activate":
        command => "/bin/bash -c 'source ${env_folder}/bin/activate'"
      , cwd => "/home/vagrant"
      , path => "/home/vagrant"
      , user   => "vagrant"
      , require => [Exec["virtualenv-create"]]
    }
}

#(vagrant)-bash-4.1$ yum install libxml2-devel.x86_64
#(vagrant)-bash-4.1$ sudo yum install libxslt-devel.x86_64

# Error: /usr/local/bin/pip-2.7 install pyodbc returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[pyodbc-install]/returns: change from notrun to 0 failed: /usr/local/bin/pip-2.7 install pyodbc returned 1 instead of one of [0]
# Notice: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns: Downloading/unpacking pyqt
# Notice: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns:   Could not find any downloads that satisfy the requirement pyqt
# Notice: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns: Cleaning up...
# Notice: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns: No distributions at all found for pyqt
# Notice: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns: Storing complete log in /root/.pip/pip.log
# Error: /usr/local/bin/pip-2.7 install pyqt returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[pyqt-install]/returns: change from notrun to 0 failed: /usr/local/bin/pip-2.7 install pyqt returned 1 instead of one of [0]

# Error: /usr/local/bin/pip-2.7 install couchbase returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[couchbase-install]/returns: change from notrun to 0 failed: /usr/local/bin/pip-2.7 install couchbase returned 1 instead of one of [0]

# Error: /usr/local/bin/pip-2.7 install pycurl returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[pycurl-install]/returns: change from notrun to 0 failed: /usr/local/bin/pip-2.7 install pycurl returned 1 instead of one of [0]

# Error: /usr/local/bin/easy_install-2.7 wxpython returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[wxpython-install]/returns: change from notrun to 0 failed: /usr/local/bin/easy_install-2.7 wxpython returned 1 instead of one of [0]

# Error: /usr/local/bin/pip-2.7 install SilverCity returned 1 instead of one of [0]
# Error: /Stage[main]/Pythonextras/Exec[silvercity-install]/returns: change from notrun to 0 failed: /usr/local/bin/pip-2.7 install SilverCity returned 1 instead of one of [0]
