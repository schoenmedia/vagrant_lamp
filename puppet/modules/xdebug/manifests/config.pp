# puppet/modules/xdebug/manifests/config.pp


define xdebug::config (
    $xdebug_remote_enable     = 1,
    $xdebug_remote_host       = localhost,
    $xdebug_remote_port       = 9000,
    $xdebug_remote_autostart  = 1,
    $xdebug_idekey = 'XDEBUG_macgdbp',
	)
{

	file { "/etc/php5/conf.d/xdebug_config.ini":
		content => template('xdebug/xdebug_config.erb'),
		owner   => root,
    	group   => root,
    	require	=> Package['php5-xdebug'],
		notify => Service[apache2],
	}


}