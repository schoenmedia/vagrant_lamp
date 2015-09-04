# puppet/modules/php/manifests/composer.pp


class php::composer {

	 exec { 'install-composer':
    		cwd     => '/root',
    		command => '/usr/bin/curl -sS https://getcomposer.org/installer | php && mv composer.phar /usr/local/bin/composer ',
    		creates => '/usr/local/bin/composer',
    		environment => 'COMPOSER_HOME=/root',
    		timeout => 0,
    		require => Package ['php5'],
  	}


}