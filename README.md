# vagrant_lamp
work in progress … configure a vbox for development purpose. All puppet modules here supports only ubuntu.
With the current configuration the vbox contains:  
- Ubuntu Precise 12.04
- Apache/2.2.22
- PHP 5.4.24-1+sury.org~precise+1 (ondrej/php5-oldstable)
- xdebug 2.2.3
- MySQL 5.5.35-0ubuntu0.12.04.1
- n98magerun.phar with automatic installation of magento-ce-1.7.0.2

## Installation
1. Download  
git clone --recursive https://github.com/schoenmedia/vagrant_lamp.git  
don´t forget the --recursive flag to get the submodules also

2. Configure config/vagrant.yaml and puppet/config/<hostname>.yaml
Al least the nfs_map_uid and apache_chown to get the nfs synced_folder work right.

3. configure on host: /etc/hosts:  
192.168.2.2 mybox.dev

4. Start the box with vagrant up



## Configuration
### config/vagrant.yaml:
These configurations are for /Vagrantfile

**The box**  

    box: precise64  
    box_url: http://files.vagrantup.com/precise64.box'


**Network**  

    ## the hostname is also relevant as node in puppet/manifests/default.pp
    hostname: vagrant.mybox.dev  
    private_network: 192.168.2.2

**synced_folder**  
Due to speed optimization I enabled nfs synced folders. Therefore network mode is 'private_network'. As far as I know the user and group of the synced folder have to share the same uid on host and client, when you for example run the apache www on the synced folder. And apache have to run on the same user. So file operations do not fail because of permission issues. E.g. if it´s not set, in magento the files in /var/session/ have th wrong permission and you can´t log-in into the administration area.  

    nfs_map_uid: 505  
    nfs_map_gid: 1000  
505 is the uid of my osx user. Later this user will be added to the box with this uid.

    synced_folder:
        folder_1:
            ## bool true | false
            disabled: false

            ## relative path on host
            host: www/default

            ## absolute path on guest
            guest: /var/www/default

            ## bool true | false
            create: true

        folder_2
             ...

**Provider**

    provider:
       virtualbox:
           ## modify the virtual machine
           modifyvm:
               natdnshostresolver1: 'on'
               memory: '4096'

**Provision**

    provision:
        puppet:
            manifests_path: puppet/manifests/
            manifest_file: site.pp
            module_path: puppet/modules
            options:
                - '--verbose'
                - '--debug'


### puppet/config/<hostname>.yaml:
In this example the file is **vagrant.mybox.dev.yaml**. This file contains all the configuration for the node 'vagrant.mybox.dev' in puppet/manifests/default.pp

**classes**  
The order of classes executed by puppet

**apache_vhosts**  
vhosts for apache

**apache_modules**  
apache modules to enable

**apache_chown**  
user, group, uid, gid change to match the nfs synced folder

**admin_ppas**  
ppa definitions e.g for php the apt_key etc.

**mysql_password**  
set the mysql password to 'secret123'

** mysql_dbs **  
set up the magento db to user 'root' and password 'secret123'

** n98magerun **
magento installation options e.g magento_version: magento-ce-1.7.0.2

**xdbebug**
xdebug options
