# Copyright (c) 2010 Curt Micol <asenchi@asenchi.com>
# Permission to use, copy, modify, and distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
 
# THE SOFTWARE IS PROVIDED 'AS IS' AND THE AUTHOR DISCLAIMS ALL WARRANTIES
# WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
# MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
# ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
# WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
# ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
# OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 
# Puppet manifest to install Python and Python modules using Pip.
 
# Defaults:
#   prefix => "/usr/local"
#   tmpdir => "/tmp"
#   pipversion => "0.6.3"
#   version => "2.6.4"
#
# Example usage:
# node myserver {
#   include python
#   python1::install { "Python-2.7.3":
#     version => "2.7.3"
#   }
 
#   python1::pip { "yolk":
#     ensure => present,
#   }
# }
 
# TODO: More ensure options for pip
# TODO: Ability to install more than one python version.

#include python1

define source_install($prefix, $tarball, $tmpdir, $flags) {
  exec { "retrieve-$name":
    command => "wget $tarball",
    cwd => "$tmpdir",
    before => Exec["extract-$name"],
    notify => Exec["extract-$name"],
  }
 
  exec { "extract-$name":
    command => "tar -zxf $name.tgz",
    cwd => $tmpdir,
    creates => "$tmpdir/$name/README",
    require => Exec["retrieve-$name"],
    before => Exec["configure-$name"],
  }
 
  exec { "configure-$name":
    cwd => "$tmpdir/$name",
    command => "./configure $flags --prefix=$prefix",
    require => Exec["extract-$name"],
    before => Exec["make-$name"],
  }
 
  exec { "make-$name":
    cwd => "$tmpdir/$name",
    command => "make && make altinstall",
    require => Exec["configure-$name"],
  }
}
 
class python1 {
  define install ($prefix = "/usr/local",$tmpdir = "/tmp",$pipversion = "0.6.3",$version = "2.6.4") {
    Exec { path => "/usr/bin:/usr/sbin:/bin:/sbin" }
    file { ["$prefix", "$tmpdir"]: ensure => directory }
 
    exec { "retrieve-distribute":
      command => "wget http://python-distribute.org/distribute_setup.py",
      cwd => $tmpdir,
      require => File["$prefix"],
    }
 
    exec { "retrieve-pip":
      command => "wget http://pypi.python.org/packages/source/p/pip/pip-$pipversion.tar.gz",
      cwd => $tmpdir,
      require => File["$prefix"],
      notify => Exec["extract-pip"],
      returns => [5],
    }
 
    exec { "extract-pip":
      command => "tar -zxf pip-$pipversion.tar.gz",
      cwd => $tmpdir,
      creates => "$tmpdir/pip-$pipversion",
      require => Exec["retrieve-pip"],
      subscribe => Exec["retrieve-pip"],
      returns => [2]
    }
 
    source_install { "Python-$version":
      prefix => $prefix,
      tarball => "http://python.org/ftp/python/$version/Python-$version.tgz",
      tmpdir => $tmpdir,
      flags => "",
    }
 
    exec { "install-distribute-$version":
      command =>"$prefix/bin/python distribute_setup.py",
      cwd => $tmpdir,
      require => [
                  Exec["retrieve-distribute"],
                  Source_install["Python-$version"]
                  ],
      before => Exec["install-pip-$version"],
    }
 
    exec { "install-pip-$version":
      command => "$prefix/bin/python setup.py install",
      cwd => "$tmpdir/pip-$pipversion",
      creates => "$prefix/bin/pip",
      subscribe => Exec["extract-pip"],
      require => [
                  Exec["extract-pip"],
                  Source_install["Python-$version"],
                  Exec["install-distribute-$version"]
                  ],
    }
  }
 
  define pip($version = undef, $ensure) {
    case $ensure {
      present: {
        exec { "pip-install-$name-$version":
	      command => "$prefix/bin/pip install $name",
	      timeout => "-1",
        }
      }
    }
  }
}