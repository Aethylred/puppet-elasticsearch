class elasticsearch::params {
    $version        = '0.90.2'
    $service_repo   = 'https://github.com/elasticsearch/elasticsearch-servicewrapper.git'
  case $::osfamily {
    RedHat:{
      $package_file     = "elasticsearch-${version}.noarch.rpm"
      $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/${package_file}"
      $package_provider = 'rpm'
      $web_root         = '/var/www/html'
      $web_user         = 'apache'
      $web_group        = 'apache'
    }
    Debian:{
      $package_file     = "elasticsearch-${version}.deb"
      $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/${package_file}"
      $package_provider = 'dpkg'
      $web_root         = '/var/www'
      $web_user         = 'www-data'
      $web_group        = 'www-data'
    }
    default:{
      fail{"Elasticsearch module not configured for ${::osfamily}.":}
    }
  }

}