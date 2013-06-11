class elasticsearch::web::head::install(
  $web_root
){
  
  $app_root  = "${web_root}/elastichead"

  class{'elasticsearch::web::head::download':
    web_root    => $web_root,
    app_root    => $app_root,
  }

  file{$app_root:
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    recurse => true,
    require => Class['elasticsearch::web::head::download'],
  }

}