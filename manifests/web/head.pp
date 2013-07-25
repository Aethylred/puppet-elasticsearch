

class elasticsearch::web::head (
  $apache_user = $elasticsearch::params::web_user,
  $web_root    = $elasticsearch::params::web_root,
  $web_group   = $elasticsearch::params::web_group,
) inherits elasticsearch::params {
  vcsrepo{"${web_root}/elastichead":
    ensure    => present,
    source    => 'git://github.com/mobz/elasticsearch-head.git',
    provider  => git,
    require   => Service['elasticsearch'],
  }

}