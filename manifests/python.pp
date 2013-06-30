# Install python 2.7.3 and compiled modules for project
class python {
    $python_package = "Python-2.7.3.tar.bz2"
    $distribute_package = "distribute-0.6.35.tar.gz"
    $env_folder = ".venv"

    File {
        owner   => "vagrant"
      , group   => "vagrant"
      , mode    => 644
      # require => Package["httpd"],
      # notify  => Service["httpd"]
    }    

    # Download, extract, make and install Python
    # exec { "python-download":
    #     command => "/usr/bin/curl -O http://www.python.org/ftp/python/2.7.3/${python_package}"
    #   , cwd => "/vagrant/files"      
    # }

    exec { "python-extract":
        command => "/bin/tar -xvjf /vagrant/files/${python_package}"
      , cwd => "/vagrant/files"
      # , require => [Exec["python-download"]]
    }

    exec { "python-configure":
        command => "./configure --prefix=/usr/"
      , path => "/vagrant/files/Python-2.7.3/"
      , require => [Exec["python-extract"]]
      , returns => [1] # successful execution returns 1
    }

    exec { "python-make":
        command => "/usr/bin/make"
      , cwd => "/vagrant/files/Python-2.7.3"
      , require => [Exec["python-configure"]]
    }

    exec { "python-install":
        command => "/usr/bin/make altinstall"
      , cwd => "/vagrant/files/Python-2.7.3"
      , require => [Exec["python-make"]]
      , user => root
      , returns => [0]
    }

    # Download and install Distribute    
    # exec { "distribute-download":
    #   command => "/usr/bin/curl -O http://pypi.python.org/packages/source/d/distribute/${distribute_package}",
    #   cwd => "/vagrant/files",
    #   require => [Exec["python-install"]]
    # }

    exec { "distribute-extract":
        command => "/bin/tar -xvzf /vagrant/files/${distribute_package}"
      , cwd => "/vagrant/files"
      # , require => [Exec["distribute-download"]]
    }

    exec { "distribute-install":
        command => "/usr/local/bin/python2.7 setup.py install"
      , cwd => "/vagrant/files/distribute-0.6.35"
      , path => "/vagrant/files/distribute-0.6.35"
      , require => [Exec["distribute-extract"]]
      , user => root
      , returns => [0]
    }

    exec { "virtualenv-install":
        command => "/usr/local/bin/easy_install-2.7 virtualenv"
      , require => [Exec["distribute-install"]]
      , user => root
    }

    # Not required.
    exec { "virtualenv-create":
        command => "/usr/local/bin/virtualenv-2.7 --distribute ${env_folder}"
      , cwd => "/home/vagrant"
      , require => [Exec["virtualenv-install"]]
      , returns => [0]
    }

    exec { "virtualenv-activate":
        command => "/bin/bash -c 'source ${env_folder}/bin/activate'"
      , cwd => "/home/vagrant"
      , path => "/home/vagrant"
      , require => [Exec["virtualenv-create"]]
    }
}