# apache/manifests/vhost.pp

define apache::vhost($domain='UNSET', $root='UNSET') {
	include apache

	if $domain == 'UNSET' {
		$vhost_domain = $name
	} else {
		$vhost_domain = $domain
	}

	if $root == 'UNSET' {  
		$vhost_root = "/var/www/${name}"
	} else {
		$vhost_root = $root
	}

	file { "/etc/apache2/sites-available/${vhost_domain}.conf":
		content => template('apache/vhost.erb'),
		require	=> Package['apache2'],
		notify	=> Exec["enable-${vhost_domain}-vhost"],
	}

	exec { "enable-${vhost_domain}-vhost":
		command	=> "/usr/sbin/a2ensite ${vhost_domain}.conf",
		require => File["/etc/apache2/sites-available/${vhost_domain}.conf"],
		refreshonly => true,
		notify => Service['apache2'],
	}

}