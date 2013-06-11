
class elasticsearch::service::download(
  $service_dir,
  $service_git_url = 'git://github.com/elasticsearch/elasticsearch-servicewrapper.git'
){

  exec{'clone_service_source':
    user      => root,
    path      => ['/usr/bin'],
    command   => "git clone -b master ${service_git_url} ${service_dir}",
    creates   => $service_dir,
    require   => File[$app_root],
  }

  file{$service_dir:
    ensure  => directory,
    require => Exec['clone_service_source'],
  }

}