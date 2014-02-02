# puppet/modules/php/xdebug/manifests/xdebug.pp

class xdebug{

	package { 'php5-xdebug':
		ensure => installed,
		require => Package['php5-cli'],
	}

}