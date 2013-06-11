# Elasticsearch manifest
# http://www.elasticsearch.org/
# https://github.com/Aethylred/puppet-elasticsearch
# Class: elasticsearch
#
# This module manages elasticsearch
#
# Parameters:
#
# Actions:
#
# Requires:
#
# Sample Usage:
#

# This file is part of the elasticsearch Puppet module.
#
#     The elasticsearch Puppet module is free software: you can redistribute it and/or modify
#     it under the terms of the GNU General Public License as published by
#     the Free Software Foundation, either version 3 of the License, or
#     (at your option) any later version.
#
#     The elasticsearch Puppet module is distributed in the hope that it will be useful,
#     but WITHOUT ANY WARRANTY; without even the implied warranty of
#     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#     GNU General Public License for more details.
#
#     You should have received a copy of the GNU General Public License
#     along with the elasticsearch Puppet module.  If not, see <http://www.gnu.org/licenses/>.

# [Remember: No empty lines between comments and class definition]
class elasticsearch(
  $version      = "0.19.2",
  $install_root = "/opt"
){
  case $operatingsystem{
    CentOS:{
      class{'elasticsearch::install':
        version       => $version,
        install_root  => $install_root,
        git_package => 'git'
      }
    }
    default:{
      warning{"ElasticSearch ${version} not configured for ${operatingsystem}":}
    }
  }
}

class elasticsearch::install(
  $version      = "0.19.2",
  $install_root = "/opt",
  $git_package = "git-core"
){
  # NOTE: This is not a good way to install something.
  # It would be better to create RPM packages and put them in
  # a repository server
  # https://github.com/tavisto/elasticsearch-rpms
  # ...or use git to clone elasticsearch...

  package{$git_package: ensure => installed}

  exec{'install_elasticsearch':
    require   => Package[$git_package],
    path      => ['/usr/bin'],
    cwd       => $install_root,
    user      => root,
    command   => "git clone git://github.com/elasticsearch/elasticsearch.git elasticsearch&& cd elasticsearch&& git checkout v${version}",
    creates   => "${install_root}/elasticsearch",
  }

  exec{'install_servicewrapper':
    require => Exec['install_elasticsearch'],
    path    => ['/usr/bin','/bin'],
    cwd     => $install_root,
    user    => root,
    command => "git clone git://github.com/elasticsearch/elasticsearch-servicewrapper.git elasticsearch-servicewrapper&& cp -R elasticsearch-servicewrapper/service elasticsearch/bin",
    creates => "${install_root}/elasticsearch/bin/service",
  }

  #file{'link_elasticsearch_wrapper':
  #  ensure  => link,
  #  require => Exec['install_servicewrapper'],
  #  owner   => root,
  #  group   => root,
  #  path    => "${install_root}/elasticsearch/bin/service",
  #  target  => "${install_root}/elasticsearch-servicewrapper/service",
  #}

  file{'link_elasticsearch_service':
    ensure  => link,
    require => Exec['install_servicewrapper'],
    owner   => root,
    group   => root,
    path    => '/etc/init.d/elasticsearch',
    target  => "${install_root}/elasticsearch/bin/service/elasticsearch",
  }

  service{'elasticsearch':
    require => File['link_elasticsearch_service'],
    ensure => running,
    enable => true,
    hasstatus => true,
    hasrestart => true,
  }
}
