

class apache::chown($user, $group) {

    require admin::user
# Source https://raw.github.com/Intracto/Puppet/master/apache2/manifests/init.pp

# Change user
exec { "ApacheUserChange" :
    command => "/bin/sed -i 's/APACHE_RUN_USER=www-data/APACHE_RUN_USER=${user}/' /etc/apache2/envvars",
    onlyif  => "/bin/grep -c 'APACHE_RUN_USER=www-data' /etc/apache2/envvars",
    require => Package["apache2-mpm-prefork"],
    notify  => Service["apache2"],
}

# Change group
exec { "ApacheGroupChange" :
    command => "/bin/sed -i 's/APACHE_RUN_GROUP=www-data/APACHE_RUN_GROUP=${group}/' /etc/apache2/envvars",
    onlyif  => "/bin/grep -c 'APACHE_RUN_GROUP=www-data' /etc/apache2/envvars",
    require => Package["apache2-mpm-prefork"],
    notify  => Service["apache2"],
}

# Source https://github.com/Intracto/Puppet/blob/master/apache2/manifests/init.pp

exec { "apache_lockfile_permissions" :
    command => "chown -R ${user}:${group} /var/lock/apache2",
    path => ["/usr/bin/","/usr/sbin/","/bin"],
    require => Package["apache2-mpm-prefork"],
    user => 'root',
    notify  => Service["apache2"],
}




}