# puppet/modules/mysql/manifests/client.pp


class mysql::client {
	package { "mysql-client":
		ensure => installed,
		require => Package['mysql-server']
	}
}