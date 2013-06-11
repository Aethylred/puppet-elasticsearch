class elasticsearch::params {
    $version        = '0.90.1',
  case $::osfamily {
    # RedHat:{
    #   $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.noarch.rpm"
    #   $package_provider = 'rpm'
    # }
    Debian:{
      $package_url      = "https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-${version}.deb"
      $package_provider = 'apt'
      $sun_package      = 'sun-java6-jre'
    }
    default:{
      fail{"Elasticsearch module not configured for ${::osfamily}."}
    }
  }

}