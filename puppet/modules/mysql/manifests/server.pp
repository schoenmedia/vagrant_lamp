# puppet/modules/mysql/manifests/server.pp

class mysql::server {
	$mysql_password = hiera('mysql_password')

	package { 'mysql-server':
		ensure => installed
	}

	service { "mysql":
		ensure => running,
	    enable => true,
		#hasrestart => true,
		#hasstatus => true,
		require => Package ['mysql-server'],
	}

	file { '/etc/mysql/my.cnf':
    	source  => 'puppet:///modules/mysql/my.cnf',
    	owner   => 'mysql',
    	group   => 'mysql',
    	notify  => Service['mysql'],
    	require => Package['mysql-server'],
  	}

  	exec { "set-mysql-password":
		unless => "/usr/bin/mysqladmin -uroot -p${mysql_password} status",
		command => "/usr/bin/mysqladmin -uroot password ${mysql_password}",
		require => Service["mysql"],
	}

}