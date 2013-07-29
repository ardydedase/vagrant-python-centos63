class misc {
  File {
      owner   => "root"
    , group   => "root"
    , mode    => 644
    # require => Package["httpd"],
    # notify  => Service["httpd"]
  }

  exec { "grap-epel":
      command => "/bin/rpm -Uvh http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm"
    , creates => "/etc/yum.repos.d/epel.repo"
    , alias   => "grab-epel"
  }
  
  package { "vim-enhanced":
      ensure  => present
  }

  # Reference: http://projects.puppetlabs.com/issues/5175
  exec { 'group-install':
      unless  => '/usr/bin/yum grouplist "Development tools" | /bin/grep "^Installed Groups"'
    , command => '/usr/bin/yum -y groupinstall "Development tools"'
    , user => root
  }

  # yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel
  package { "zlib-devel":
      ensure  => present    
  }

  package { "bzip2-devel":
      ensure  => present     
  }

  package { "openssl-devel":
      ensure  => present          
  }

  package { "ncurses-devel":
      ensure  => present          
  }

  package { "sqlite-devel":
      ensure  => present        
  }

  package { "readline-devel":
      ensure  => present    
  }

  package { "tk-devel":
      ensure  => present          
  }  

  package { "dos2unix":
      ensure  => present          
  }

}