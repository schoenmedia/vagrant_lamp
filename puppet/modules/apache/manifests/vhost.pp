# apache/manifests/vhost.pp

define apache::vhost($domain='UNSET', $docroot='UNSET') {
	include apache

	if $domain == 'UNSET' {
		$vhost_domain = $name
	} else {
		$vhost_domain = $domain
	}

	if $docroot == 'UNSET' {  
		$vhost_root = "/var/www/${name}"
	} else {
		$vhost_root = $docroot
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