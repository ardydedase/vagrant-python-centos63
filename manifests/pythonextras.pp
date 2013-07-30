# Install python packages
class pythonextras {
    $python_package = "Python-2.7.3.tar.bz2"
    $distribute_package = "distribute-0.6.35.tar.gz"
    $env_folder = ".venv"
    $path = "/vagrant/files/Python-2.7.3:/home/vagrant/bin:/usr/sbin:/usr/bin:/sbin:/bin"


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
        command => "/usr/local/bin/easy_install-2.7 virtualenv"
      #, require => [Exec["distribute-install"]]     
       , require => [Class["python"]]
    }

    exec { "pip-install":
        command => "/usr/local/bin/easy_install-2.7 pip"
      #, require => [Exec["distribute-install"]]
      , require => [Class["python"]]
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