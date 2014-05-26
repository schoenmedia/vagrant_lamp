hiera_include('classes')

node 'vagrant.mybox.dev' {
	$ppas = hiera('admin_ppas', [])
	create_resources('admin::pparepo',$ppas)

	$php_ppa = hiera('admin_ppa_php')
	
	class{"php":
		php_ppa => $php_ppa,

	}
 
	class{"php::composer":}

	# create a group with a specific GID.
	$apache_chown  = hiera('apache_chown')

	$user = $apache_chown[0]['user']
	$group = $apache_chown[0]['group']
	$uid = $apache_chown[0]['uid']
	$gid = $apache_chown[0]['gid']


	class{"admin::user":
		user => $user,
		group => $group,
		uid => $uid,
		gid => $gid,
	}


	

	class{"apache::chown":
		user  => $user,
		group => $group,
	}

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