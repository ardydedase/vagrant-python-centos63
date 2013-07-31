class httpd {

  File {
      owner   => "root"
    , group   => "root"
    , mode    => 644
    , require => Package["httpd"]
    , notify  => Service["httpd"]
  }

  package { "httpd":
    ensure => present
  }

  package { "httpd-devel":
    ensure  => present
  }

  package { "mod_ssl":
    ensure  => present
  }

  service { 'httpd':
      name      => 'httpd'
    , require   => Package["httpd"]
    , ensure    => running
    , enable    => true
  }

  file { "/etc/httpd/conf.d/vhost.conf":
      replace => true
    , ensure  => present
    , source  => "/vagrant/files/httpd/conf.d/vhost.conf"
  }

  file { "/etc/httpd/vhosts_ssl":
      ensure => "directory"
  }


  file { "/etc/httpd/vhosts":
      replace => true
    , ensure  => present
    , source  => "/vagrant/files/httpd/vhosts"
    , recurse => true
  }

}