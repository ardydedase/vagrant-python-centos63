# Python 2.7 setup on CentOS 6.3 with Vagrant and Puppet

This VM installs Python 2.7 on CentOS 6.3 utilizing virtualenv.
CentOS 6.3 ships with Python 2.6.* by default. You can install a newer version of Python but you should 
avoid modifying its system python. Packages like yum and other utilities depend on the shipped version 
of Python. Modifying it might cause problems in the future.

## Installation

- Install VirtualBox - [https://www.virtualbox.org/wiki/Downloads](https://www.virtualbox.org/wiki/Downloads)
- Install Vagrant - [http://downloads.vagrantup.com](http://downloads.vagrantup.com/)
- Clone this repo into your local folder.
- `cd` into the root folder of the repo and run `vagrant up`

## Usage
- To login to the box, make sure you're inside the root folder and run: `vagrant ssh`
- Other commands:

To stop the running machine Vagrant is managing and destroys all resources that were created during the machine creation process:
```bash
$ vagrant destroy
```

Suspends the guest machine Vagrant is managing, rather than fully shutting it down or destroying it:
```bash
$ vagrant suspend
```

Resumes a Vagrant managed machine that was previously suspended:
```bash
$ vagrant resume
```

Shut down the running machine Vagrant is managing:
```bash
$ vagrant halt
```

## Common Gotchas and How to Troubleshoot them 

http://docs-v1.vagrantup.com/v1/docs/troubleshooting.html

## Reference

http://toomuchdata.com/2012/06/25/how-to-install-python-2-7-3-on-centos-6-2/