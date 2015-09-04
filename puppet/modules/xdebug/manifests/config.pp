# puppet/modules/xdebug/manifests/config.pp


define xdebug::config (
    $zend_extension = '/usr/lib/php5/20121212/xdebug.so',
    $xdebug_remote_enable     = 1,
    $xdebug_remote_host       = localhost,
    $xdebug_remote_port       = 9000,
    $xdebug_remote_autostart  = 1,
    $xdebug_idekey = 'XDEBUG_macgdbp',
	)
{

	file { "/etc/php5/mods-available/xdebug_config.ini":
		content => template('xdebug/xdebug_config.erb'),
		owner   => root,
    	group   => root,
    	require	=> Package['php5-xdebug'],
		notify => Service[apache2],
	}


}