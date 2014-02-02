# vagrant_lamp
work in progress … configure a vbox for development purpose. All puppet modules here supports only ubuntu.
With the current configuration the vbox contains:  
- Ubuntu Precise 12.04
- Apache/2.2.22
- PHP 5.4.24-1+sury.org~precise+1 (ondrej/php5-oldstable)
- xdebug 2.2.3
- MySQL 5.5.35-0ubuntu0.12.04.1
- n98magerun.phar with automatic installation of magento-ce-1.7.0.2 

/etc/hosts auf dem host anpassen:  
33.33.33.10 mybox.dev

## For an easier configuration I used .yaml files:    

**- configure Vagrantfile: config/vagrant.yaml**  
Here you can configure the main parts of Vagrantfile.
box, network, synced_folder, provider etc.

**- configure puppet modules with hiera: puppet/config/vagrant.mybox.dev.yaml**  
 The name of the *.yaml file depends on the vagrant hostname.
And is also used for the puppet/manifests/node.pp  

don´t forget the --recursive to get the submodules also
<code>
git clone --recursive https://github.com/schoenmedia/vagrant_lamp.git
</code>
