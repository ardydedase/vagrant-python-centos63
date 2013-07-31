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
    # exec { "pywin32-install":
    #     command => "${easy_install} pywin32"      
    # }

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

    exec { "squaremap-install":
        command => "${pip_install} squaremap"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }

    exec { "runsnakerun-install":
        command => "${pip_install} runsnakerun"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }

    exec { "couchbase-install":
        command => "${pip_install} couchbase"      
      , require => [Exec['pip-install']]
      , returns => [1, 2]
    }
}

# squaremap, runsnakerun are not working
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
