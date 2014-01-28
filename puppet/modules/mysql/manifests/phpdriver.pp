# puppet/modules/mysql/manifests/phpdriver.pp


class mysql::phpdriver {
	package { "php5-mysqlnd":
		ensure => installed,
	}
}
