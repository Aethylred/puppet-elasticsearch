

class elasticsearch::web::head(
  $web_root     = '/var/www/html'
){
  case $operatingsystem {
    CentOS:{
      class{'elasticsearch::web::head::install':
        web_root => $web_root,
      }
    }
    default:{
      warning("Elasticsearch-head web UI is not configured for ${operatingsystem} on ${fqdn}")
    }
  }
}