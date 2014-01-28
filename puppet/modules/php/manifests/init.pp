# puppet/modules/php/manifests/init.pp


class php($php_ppa) {


	package { "php5":
		ensure => installed,
		require => Admin::Pparepo[$php_ppa],
	}

	package {"php5-cli":
		ensure => present,
	}

	package { "php5-mcrypt":
		ensure => present,
	}

	package { "php5-curl":
		ensure => present,
	}

	package { "php5-gd":
		ensure => present,
	}

	package { "php5-memcache":
		ensure => present,
	}

	package { "php-apc":
		ensure => present,
		notify => Service[apache2],
		
	}

}