# Elasticsearch install manifest
# DO NOT CALL DIRECTLY
# Include the parent clas instead:
# include elasticsearch

class elasticsearch::install(
  $version,
  $app_root,
  $app_url,
  $conf_path,
  $data_path,
  $cluster_name,
  $node_name,
  $master_node,
  $data_node,
  $node_rack,
  $service_git_url
){

  $app_dir  = "${app_root}/elasticsearch-${version}"
  $log_dir         = "/var/log/elasticsearch"

  $conf_dir = $conf_path ? {
    false   => "${app_dir}/config",
    default => $conf_path, 
  }

  file{$app_root:
    ensure  => directory,
  }

  class{'elasticsearch::download':
    version         => $version,
    app_root        => $app_root,
    app_dir         => $app_dir,
    app_url         => $app_url,
  }

  file{$conf_dir:
    ensure  => directory,
    owner   => root,
    group   => root,
    require => File[$app_dir],
  }

  if $data_path {
    file{$data_path:
      ensure  => directory,
      owner   => root,
      group   => root,
      require => File[$app_dir],
    }
  }

  file{$log_dir:
    ensure    => directory,
    owner     => root,
    group     => root,
    require   => File[$app_dir],
  }

  file{'app_config':
    ensure    => file,
    owner     => root,
    group     => root,
    path      => "${app_dir}/config/elasticsearch.yml",
    content   => template("elasticsearch/elasticsearch.yml.erb"),
    require   => $data_path ? {
      false   => File[$conf_dir,$log_dir],
      default => File[$conf_dir,$log_dir,$data_path],
    },
    notify    => Service['elasticsearch'],
  }

  file{'log_config':
    ensure    => file,
    owner     => root,
    group     => root,
    path      => "${app_dir}/config/logging.yml",
    content   => template("elasticsearch/logging.yml.erb"),
    require   => File[$conf_dir,$log_dir,'app_config'],
    notify    => Service['elasticsearch'],
  }

  if $conf_dir {
    file{'link_app_conf':
      ensure  => link,
      owner   => root,
      group   => root,
      path    => "${conf_dir}/elasticsearch.yml",
      target  => "${app_dir}/config/elasticsearch.yml",
      require => File['app_config'],
    }
    file{'link_log_conf':
      ensure  => link,
      owner   => root,
      group   => root,
      path    => "${conf_dir}/logging.yml",
      target  => "${app_dir}/config/logging.yml",
      require => File['log_config'],
    }
  }

  class{'elasticsearch::service':
    conf_dir  => $conf_dir,
    app_root  => $app_root,
    app_dir   => $app_dir,
    log_dir   => $log_dir,
    service_git_url => $service_git_url,
  }
}