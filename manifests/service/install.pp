# Installs the elasticsearch init scripts
# Do not call directly, use elasticsearch::service

class elasticsearch::service::install(
  $conf_dir,
  $app_root,
  $app_dir,
  $log_dir,
  $service_git_url
){

  $service_dir  = "${app_root}/elasticsearch-service"
  $service_root = "${app_dir}/bin/service"
  
  class {'elasticsearch::service::download':
    service_dir        => $service_dir,
    service_git_url => $service_git_url,
  }

  exec{'copy_service_dir':
    user    => root,
    path    => ['/bin'],
    command => "cp -R  ${service_dir}/service ${service_root}",
    require => File[$service_dir,$app_dir],
    creates => $service_root,
  }

  exec{'install_service':
    user    => root,
    cwd     => $service_root,
    command => "${service_root}/elasticsearch install",
    require => Exec['copy_service_dir'],
    creates => '/etc/init.d/elasticsearch',
  }

  file{'service_conf':
    ensure  => file,
    owner   => root,
    group   => root,
    path    => "${service_root}/elasticsearch.conf",
    content => template("elasticsearch/elasticsearch.conf.erb"),
    notify  => Service['elasticsearch'],
  }

  service{'elasticsearch':
    ensure      => running,
    hasstatus   => true,
    hasrestart  => true,
    enable      => true,
    require     => [Exec['install_service'],File['app_config']],
  }
}