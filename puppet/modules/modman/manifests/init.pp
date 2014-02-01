# puppet/modules/modman/manifests/init.pp


class modman {

	file { '/usr/local/bin/modman':
    	source  => 'puppet:///modules/modman/modman',
    	mode    => '0755',
    	owner   => root,
    	group   => root,
  	}

 
   

}