# Installs the elasticsearch service wrapper modified from:
# https://github.com/elasticsearch/elasticsearch-servicewrapper

class elasticsearch::service(
  $conf_dir,
  $app_root,
  $app_dir,
  $log_dir,
  $service_git_url
){
  case $operatingsystem {
    CentOS: {
      class {'elasticsearch::service::install':
        conf_dir        => $conf_dir,
        app_root        => $app_root,
        app_dir         => $app_dir,
        log_dir         => $log_dir,
        service_git_url => $service_git_url,
      }
    }
    default: {
      warning("elasticsearch service script is not configured for ${operatingsystem} on ${fqdn}")
    }
  }
}