class elasticsearch::web::bigdesk(
  $web_root = '/var/www/html'
){
  case $operatingsystem {
    CentOS:{
      class{'elasticsearch::web::bigdesk::install':
        web_root => $web_root,
      }
    }
    default:{
      warning("BigDesk web UI is not configured for ${operatingsystem} on ${fqdn}")
    }
  }
}