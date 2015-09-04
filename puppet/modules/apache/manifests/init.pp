# modules/apache/manifests/init.pp

class apache($apache_ppa) {

	package { "apache2":
		ensure => installed,
		require => Admin::Pparepo[$apache_ppa]
	}


	service { "apache2":
	    enable => true,
		ensure => running,
		#hasrestart => true,
		#hasstatus => true,
		require => Package ['apache2'],
		
	}

}