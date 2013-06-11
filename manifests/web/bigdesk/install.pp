class elasticsearch::web::bigdesk::install(
  $web_root
){
  
  $app_root  = "${web_root}/bigdesk"

  class{'elasticsearch::web::bigdesk::download':
    web_root    => $web_root,
    app_root    => $app_root,
  }

  file{$app_root:
    ensure  => directory,
    owner   => 'apache',
    group   => 'apache',
    recurse => true,
    require => Class['elasticsearch::web::bigdesk::download'],
  }

}