class elasticsearch::web::head::download(
  $web_root,
  $app_root
){
  exec{'get_elastichead':
    cwd       => $web_root,
    user      => root,
    path      => ['/usr/bin'],
    command   => "git clone -b master git://github.com/mobz/elasticsearch-head.git ${app_root}",
    creates   => $app_root,
    require   => Service['elasticsearch'],
    notify    => Service['apache'],
  }
}