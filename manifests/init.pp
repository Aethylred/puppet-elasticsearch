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
# NeSI Elasticsearch manifest v2
# The old manifest installed by including tarballs in the puppet git repository
# which is not ideal. Rewriting to download and install a stable version directly.
# [Remember: No empty lines between comments and class definition]
class elasticsearch(
  $package_url      = $elasticsearch::params::package_url,
  $package_file     = $elasticsearch::params::package_file,
  $heap_size        = undef,
  $max_open_files   = 65535,
  $data_dir         = undef,
  $log_dir          = undef,
  $cluster_name     = false,
  $node_name        = false,
  $master_node      = false,
  $data_node        = true,
  $node_rack        = false,
  $service_git_url  = 'git://github.com/elasticsearch/elasticsearch-servicewrapper.git'
) inherits elasticsearch::params {

  exec{'download_elasticsearch':
    cwd     => '/tmp',
    command => "/usr/bin/wget ${package_url}",
    unless  => '/usr/bin/dpkg-query -l elasticsearch',
    before  => Package['elasticsearch'],
  }

  package{'elasticsearch':
    ensure    => installed,
    source    => "/tmp/${package_file}",
    provider  => $elasticsearch::params::package_provider,
  }

  service{'elasticsearch':
    ensure      => running,
    enable      => true,
    hasstatus   => true,
    hasrestart  => true,
    require     => Package['elasticsearch'],
  }

  file{'elasticserch_init':
    ensure    => file,
    path      => '/etc/init.d/elasticsearch'
    owner     => root,
    group     => root,
    mode      => 0755,
    content   => template('elasticsearch/elasticsearch.erb'),
    require   => Package['elasticsearch'],
    notify    => Service['elasticsearch'],
  }

}
