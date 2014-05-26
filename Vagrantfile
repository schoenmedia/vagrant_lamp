# load /config/vagrant.yaml
require 'yaml'
yml = YAML.load_file('./config/vagrant.yaml')

# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  # Every Vagrant virtual environment requires a box to build off of.
  if !yml['vm']['box'].nil?
    config.vm.box = "#{yml['vm']['box']}"
  end

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  if !yml['vm']['box_url'].nil?
    config.vm.box_url = "#{yml['vm']['box_url']}"
  end

  # The hostname the machine should have. Defaults to nil. If nil, 
  # Vagrant won't manage the hostname. If set to a string, the 
  # hostname will be set on boot.
    
  if !yml['vm']['hostname'].nil?
    config.vm.hostname =  "#{yml['vm']['hostname']}"
  end

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network :forwarded_port, guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  if !yml['vm']['network']['private_network'].nil?
    config.vm.network :private_network, ip: "#{yml['vm']['network']['private_network']}"
  end

  # set the mapall direction in /etc/exports on host system
  # important to sync user/group on host and guest when you use nfs for shared folder
  config.nfs.map_uid = Process.uid # "#{yml['vm']['nfs_map_uid']}"
  config.nfs.map_gid = Process.gid #{}"#{yml['vm']['nfs_map_gid']}"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network :public_network

  # If true, then any SSH connections made will enable agent forwarding.
  # Default value: false
  # config.ssh.forward_agent = true

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  yml['vm']['synced_folder'].each do |i,dir|
    complete = true
    dir.each do |a,val|
      if val.nil?
        complete = false
      end
    end
      
    if complete
      config.vm.synced_folder "#{dir['host']}", "#{dir['guest']}" , disabled: dir['disabled'], create: dir['create'],  type: "nfs", :linux__nfs_options => ["no_root_squash"] 
    end
  end
  
  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider :virtualbox do |vb|
  #   # Don't boot with headless mode
  #   vb.gui = true
  #
  #   # Use VBoxManage to customize the VM. For example to change memory:
  #   vb.customize ["modifyvm", :id, "--memory", "1024"]
  # end
  #
  # View the documentation for the provider you're using for more
  # information on available options.
  
  if !yml['vm']['provider']['virtualbox'].nil?
    config.vm.provider :virtualbox do |virtualbox|
      yml['vm']['provider']['virtualbox']['modifyvm'].each do |key, val|
        virtualbox.customize ["modifyvm", :id, "--#{key}", "#{val}"]
      end
    end
  end

  config.vm.provision :shell, :path => "shell/upgrade-puppet.sh"

  # Enable provisioning with Puppet stand alone.  Puppet manifests
  # are contained in a directory path relative to this Vagrantfile.
  # You will need to create the manifests directory and a manifest in
  # the file base.pp in the manifests_path directory.
  #
  # An example Puppet manifest to provision the message of the day:
  #
  # # group { "puppet":
  # #   ensure => "present",
  # # }
  # #
  # # File { owner => 0, group => 0, mode => 0644 }
  # #
  # # file { '/etc/motd':
  # #   content => "Welcome to your Vagrant-built virtual machine!
  # #               Managed by Puppet.\n"
  # # }
  #
  # config.vm.provision :puppet do |puppet|
  #   puppet.manifests_path = "manifests"
  #   puppet.manifest_file  = "site.pp"
  # end
  if !yml['vm']['provision']['puppet'].nil?
    config.vm.provision :puppet do |puppet|
      puppet.manifests_path = "#{yml['vm']['provision']['puppet']['manifests_path']}"
    #  puppet.manifest_file  = "#{yml['vm']['provision']['puppet']['manifest_file']}"
      puppet.module_path = "#{yml['vm']['provision']['puppet']['module_path']}"
      puppet.options = yml['vm']['provision']['puppet']['options']
      puppet.hiera_config_path = "puppet/hiera.yaml"
      
      
    end
  end

  

  
end
