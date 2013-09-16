$rails_user = "vagrant"
$project_name = "arcade"
$ruby_version= "2.0.0-p247"
$rails_version = "4.0.0"

$bash_prefix = "sudo -u ${rails_user} -H bash -l -c"

Exec {
  path => ["/usr/sbin", "/usr/bin", "/sbin", "/bin"]
}


# --- Preinstall Stage ---------------------------------------------------------
stage { "preinstall":
  before => Stage["main"];
}

class apt_get_update {
  exec { "/usr/bin/apt-get -y update":
    user => "root";
  }
}
class { "apt_get_update":
  stage => preinstall;
}


# --- Install Packages ---------------------------------------------------------
stage { "install_packages":
  before => Stage["main"],
  require => Stage["preinstall"];
}
class install_packages {
  package {
    ["build-essential",
    "zlib1g-dev",
    "libssl-dev",
    "libreadline-dev",
    "git-core",
    "libxml2",
    "libxml2-dev",
    "libxslt1-dev",
    "memcached",
    "redis-server",
    "mongodb",
    "imagemagick",
    "libpng-dev",
    "nodejs"]:
      ensure => installed;
  }
}
class { "install_packages":
  stage => install_packages;
}

# RMagick system dependencies
package { ["libmagickwand4", "libmagickwand-dev"]:
  ensure => installed;
}


class install_mysql {
  class { 'mysql': }

  class { 'mysql::server':
    config_hash => { 'root_password' => 'aba0954' }
  }

  package { 'libmysqlclient15-dev':
    ensure => installed
  }
}
class { 'install_mysql': }



class install_postgres {
  class { 'postgresql': }

  class { 'postgresql::server': }

  pg_user { 'vagrant':
    ensure    => present,
    password  => 'vagrant',
    superuser => true,
    require   => Class['postgresql::server']
  }

  package { 'libpq-dev':
    ensure => installed
  }

}
class { 'install_postgres': }



# --- Install RVM --------------------------------------------------------------
class install-rvm {
  include rvm
  rvm::system_user { "${rails_user}": ; }

  rvm_system_ruby {
    "${ruby_version}":
      ensure => "present",
      default_use => true;
  }
}
class { "install-rvm": }


# --- Install Gems into ruby 2.0.0----------------------------------------------
class install-gems {
  exec { "${bash_prefix} 'gem install puppet --no-rdoc --no-ri'": }
  exec { "${bash_prefix} 'gem install rails --no-rdoc --no-ri'": }
  exec { "${bash_prefix} 'gem install bundler --no-rdoc --no-ri'": }
  exec { "${bash_prefix} 'gem install rake --no-rdoc --no-ri'": }
}
class { "install-gems": require => Class["install-rvm"] }


# --- Create Gemset ------------------------------------------------------------
class create-gemset {
  include rvm
  rvm_gemset {
    "${ruby_version}@${project_name}":
      ensure => present;
  }
}
class { "create-gemset": require => Class["install-rvm"] }


# --- Create RVMRC -------------------------------------------------------------
class create-rvmrc {
  exec { "remove_rvmrc":
    path   => "/usr/bin:/usr/sbin:/bin",
    command => "rm -f /vagrant/code/.rvmrc";
  }
  file { "/vagrant/code":
    ensure => "directory",
    require => Exec['remove_rvmrc'];
  }
  exec {
    "${bash_prefix} 'echo rvm use ${ruby_version}@${project_name} >> /vagrant/code/.rvmrc'":
    require => File['/vagrant/code'];
  }
  exec {
    "${bash_prefix} 'echo rvm rvmrc warning ignore /vagrant/code/.rvmrc >> /vagrant/code/.rvmrc'":
    require => File['/vagrant/code'];
  }
}
class { create-rvmrc: }
