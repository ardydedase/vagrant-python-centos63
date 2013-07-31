# Install python packages
class download {
    $python_package = "Python-2.7.3.tar.bz2"
    $distribute_package = "distribute-0.6.35.tar.gz"
    $env_folder = ".venv"
    $path = "/tmp/Python-2.7.3:/home/vagrant/bin:/usr/sbin:/usr/bin:/sbin:/bin"

    # Download, extract, make and install Python
    exec { "python-download":
        command => "/usr/bin/wget http://www.python.org/ftp/python/2.7.3/${python_package}"
      , cwd => "/tmp"
    }

    # Download and install Distribute    
    exec { "distribute-download":
        command => "/usr/bin/wget --no-check-certificate http://pypi.python.org/packages/source/d/distribute/${distribute_package}"
      , cwd => "/tmp"      
    }
}