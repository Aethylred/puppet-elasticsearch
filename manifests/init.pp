# NeSI Elasticsearch manifest v2
# The old manifest installed by including tarballs in the puppet git repository
# which is not ideal. Rewriting to download and install a stable version directly.

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