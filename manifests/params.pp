class elasticsearch::params {
    $version        = '0.90.2'
    $service_repo   = 'https://github.com/elasticsearch/elasticsearch-servicewrapper.git'
  case $::osfamily {
    RedHat:{
      $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.noarch.rpm"
      $package_provider = 'rpm'
    }
    Debian:{
      $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb"
      $package_provider = 'dpkg'
    }
    default:{
      fail{"Elasticsearch module not configured for ${::osfamily}.":}
    }
  }

}