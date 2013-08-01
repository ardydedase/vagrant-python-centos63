class iptables {

  package { "iptables": 
    ensure => present;
  }

  service { "iptables":
      require => Package["iptables"]
    , hasstatus => true
    , status => "true"

  }

  file { "/etc/sysconfig/iptables":
      owner   => "root"
    , group   => "root"
    , mode    => 600
    , replace => true
    , ensure  => present
    , source  => "/vagrant/files/iptables.txt"
    , require => Package["iptables"]
    , notify  => Service["iptables"]
  }

}