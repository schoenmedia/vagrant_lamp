# modules/apache/manifests/init.pp

class apache {
	package { 'apache2-mpm-prefork':
		ensure => installed
	}

	service { "apache2":
	    enable => true,
		ensure => running,
		#hasrestart => true,
		#hasstatus => true,
		require => Package ['apache2-mpm-prefork'],
		
	}
}