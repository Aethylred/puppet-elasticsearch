# Download the elasticsearch source
# DO NOT CALL DIRECTLY
# Include the parent clas instead:
# include elasticsearch

class elasticsearch::download(
  $version,
  $app_root,
  $app_dir,
  $app_url
){

  exec{'get_elasticsearch':
    cwd     => $app_root,
    path    => ['/usr/bin','/bin'],
    user    => root,
    command => "wget -O - ${app_url}|tar xzv",
    creates => $app_dir,
    require => File[$app_root],
  }

  file{$app_dir:
    ensure  => directory,
    require => Exec['get_elasticsearch'],
  }

}