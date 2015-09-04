
define admin::pparepo (
    $apt_key = '',
    $launchpad_id = '',
    $priority = '',
  )
{
 $ppa_name = regsubst($name, '/', '-', 'G')
 $source_list_d = "/etc/apt/sources.list.d/${ppa_name}.list"
 $preference_d = "/etc/apt/preferences.d/00${ppa_name}.pref"
 $deb = "deb http://ppa.launchpad.net/${name}/ubuntu precise main"

  exec { "${name}-add-apt-key":
    command => "/usr/bin/apt-key adv --recv-keys --keyserver keyserver.ubuntu.com ${apt_key}",
    unless  => "/usr/bin/apt-key list | /bin/grep ${name}",
    notify  => Exec["${name}-apt-update"],
    logoutput   => on_failure,
  }

  exec { "${name}-apt-update":
    command     => '/usr/bin/apt-get update',
    require     => [File[$source_list_d], File[$preference_d]],
    refreshonly => true,
  }

  file { $source_list_d:
    content => $deb,
    notify  => Exec["${name}-apt-update"],
  }

  file { $preference_d:
    content => "Package: *\nPin: release o=${launchpad_id}\nPin-Priority: ${priority}",
    notify  => Exec["${name}-apt-update"],
  }



}