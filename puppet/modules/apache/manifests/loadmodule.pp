# puppet/module/apache/manifests/loadmodule.pp


define apache::loadmodule () {
     exec { "/usr/sbin/a2enmod $name" :
          unless => "/bin/readlink -e /etc/apache2/mods-enabled/${name}.load",
          notify => Service[apache2],
          require => Package ['apache2'],
     }

}