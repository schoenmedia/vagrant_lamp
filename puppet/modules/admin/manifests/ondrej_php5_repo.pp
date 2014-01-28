# puppet/manifests/ondrej_php5_repo.pp 

class admin::ondrej_php5_repo {
  exec { 'add-ondrej_php5-apt-key':
    unless  => '/usr/bin/apt-key list | grep ondrej',
    command => '/usr/bin/gpg --keyserver  hkp://keyserver.ubuntu.com --recv-keys E5267A6C && /usr/bin/gpg -a --export E5267A6C | apt-key add -',
    notify  => Exec['ondrej_php5-apt-update'],
  }

  exec { 'ondrej_php5-apt-update':
    command     => '/usr/bin/apt-get update',
    require     => [File['/etc/apt/sources.list.d/ondrej_php5.list'], File['/etc/apt/preferences.d/00ondrej_php5.pref']],
    refreshonly => true,
  }

  file { '/etc/apt/sources.list.d/ondrej_php5.list':
    content => 'deb http://ppa.launchpad.net/ondrej/php5/ubuntu precise main',
    notify  => Exec['ondrej_php5-apt-update'],
  }

  file { '/etc/apt/preferences.d/00ondrej_php5.pref':
    content => "Package: *\nPin: release o=https://launchpad.net/~ondrej/+archive/php5\nPin-Priority: 1001",
    notify  => Exec['ondrej_php5-apt-update'],
  }



}