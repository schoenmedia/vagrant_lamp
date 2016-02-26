class n98magerun(
  $php_package = 'php5-cli',
  $install_dir = '/usr/local/bin',
  $stable      = true
) {

  if $stable {
    $download_path = 'https://files.magerun.net/n98-magerun-latest.phar'    
  } else {
    $download_path = 'https://files.magerun.net/n98-magerun-dev.phar'    
  }
   
  exec { 'download n98-magerun':
    command     => "/usr/bin/curl -o n98-magerun.phar ${download_path}",
    creates     => "${install_dir}/n98-magerun.phar",
    cwd         => $install_dir,
    require     => [Package['curl', $php_package]]
  }

  file { 'n98-magerun.phar':
    path    => "${install_dir}/n98-magerun.phar",
    mode    => '0755',
    owner   => root,
    group   => root,
    require => Exec['download n98-magerun']
  }

  
}
