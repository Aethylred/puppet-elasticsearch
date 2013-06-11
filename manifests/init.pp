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
  $version        = '0.19.4',
  $app_root       = '/opt',
  $conf_path      = false,
  $data_path      = false,
  $cluster_name   = false,
  $node_name      = false,
  $master_node    = false,
  $data_node      = true,
  $node_rack      = false,
  $service_git_url = 'git://github.com/elasticsearch/elasticsearch-servicewrapper.git'
){

  $app_url = "https://github.com/downloads/elasticsearch/elasticsearch/elasticsearch-${version}.tar.gz"

  case $operatingsystem {
    CentOS: {
      class{'elasticsearch::install':
        version         => $version,
        app_root        => $app_root,
        app_url         => $app_url,
        conf_path       => $conf_path,
        data_path       => $data_path,
        cluster_name    => $cluster_name,
        node_name       => $node_name,
        master_node     => $master_node,
        data_node       => $data_node,
        node_rack       => $node_rack,
        service_git_url => $service_git_url
      }
    }
    default: {
      warning("WARNING elasticsearch is not configured for ${operatingsystem} on ${fqdn}")
    }
  }
}
