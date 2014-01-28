class admin::curl {
	package { 'curl':
		ensure => present,
	}
}