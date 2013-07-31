# Install python 2.7.3 and compiled modules for project
class python {
    $python_package = "Python-2.7.3.tar.bz2"
    $distribute_package = "distribute-0.6.35.tar.gz"    
    $path = "/tmp/Python-2.7.3:/home/vagrant/bin:/usr/sbin:/usr/bin:/sbin:/bin"    

    File {
        owner   => "vagrant"
      , group   => "vagrant"
      , mode    => 644
      , require => Package["httpd"]
      , notify  => Service["httpd"]
    }

    exec { "python-extract":
        command => "/bin/tar -xvjf /tmp/${python_package}"
      , cwd => "/tmp"
      , require => [Class["download"]]
      , returns => [0]
    }

    exec { "python-configure":
        command => "./configure --prefix=/usr/local"
      , path => $path
      , cwd => "/tmp/Python-2.7.3/"
      , require => [Exec["python-extract"]]
      , before => [Exec["python-make"]]
      #, user => root
      , returns => [0]
    }

    exec { "python-make":
        command => "/usr/bin/make"
      , path => $path
      , cwd => "/tmp/Python-2.7.3/"
      , require => [Exec["python-configure"]]
      , returns => [0]
    }

    exec { "python-install":
        command => "/usr/bin/make altinstall"      
      , path => $path      
      , cwd => "/tmp/Python-2.7.3/"
      , require => [Exec["python-make"]]
      , user => root
      , returns => [0]
    }

    exec { "distribute-extract":
        command => "/bin/tar -xvzf /tmp/${distribute_package}"
      , cwd => "/tmp"
      , require => [Class["download"]]
      , returns => [0]
    }

    exec { "distribute-install":
        command => "/usr/local/bin/python2.7 setup.py install"
      , cwd => "/tmp/distribute-0.6.35"
      , path => "/tmp/distribute-0.6.35"
      , require => [Exec["distribute-extract"]]
      , returns => [0]
    }
}