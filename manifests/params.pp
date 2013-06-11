class elasticsearch::params {
  case $::osfamily {
    RedHat:{

    }
    Debian:{

    }
    default:{
      fail{"Elasticsearch module not configured for ${::osfamily}."}
    }
  }
}