
node 'vagrant.mybox.dev' {
	$ppas = hiera('admin_ppas', [])
	create_resources('admin::pparepo',$ppas)

	$php_ppa = hiera('admin_ppa_php')
	
	class{"php":
		php_ppa => $php_ppa,

	}
 
	class{"php::composer":}

	$xdebug = hiera('xdebug', [])
	create_resources('xdebug::config',$xdebug)

	$vhosts = hiera('apache_vhosts', [])
	create_resources('apache::vhost',$vhosts)

	$apache_modules = hiera('apache_modules', [])
	create_resources('apache::loadmodule', $apache_modules)

	$mysql_dbs = hiera('mysql_dbs', [])
	create_resources('mysql::db',$mysql_dbs)

	$n98magerun = hiera('n98magerun', [])
	class {"n98magerun::install":
		installation_folder => $n98magerun['installation_folder'],
        db_host             => $n98magerun['db_host'],
        db_user             => $n98magerun['db_user'],
        db_pass             => $n98magerun['db_pass'],
        db_name             => $n98magerun['db_name'],
        base_url            => $n98magerun['base_url'],
        install_sample_data => $n98magerun['install_sample_data'],

	}

}