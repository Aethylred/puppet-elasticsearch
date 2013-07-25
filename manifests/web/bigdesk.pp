class elasticsearch::web::bigdesk (
  $apache_user = $elasticsearch::params::web_user,
  $web_root    = $elasticsearch::params::web_root,
  $web_group   = $elasticsearch::params::web_group,
) inherits elasticsearch::params {

  vcsrepo{"${web_root}/bigdesk":
    ensure    => present,
    source    => 'git@github.com:lukas-vlcek/bigdesk.git',
    provider  => git,
    require   => Service['elasticsearch'],
  }

}