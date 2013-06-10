# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.berkshelf.enabled = true

  # Liferay Box
  config.vm.define :liferay do |liferay|

    liferay.vm.box = "precise64"

    liferay.vm.box_url = "http://files.vagrantup.com/precise64.box"

    liferay.vm.provider "virtualbox" do |v|
      v.name = "Liferay"

      v.customize ["modifyvm", :id, "--memory", 2048]
    end

    liferay.vm.network :private_network, ip: "172.16.30.10"

    liferay.vm.provision :chef_solo do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "unzip"
      chef.add_recipe "imagemagick"
      chef.add_recipe "java"
      chef.add_recipe "liferay"
      chef.add_recipe "liferay::aliases"
      chef.add_recipe "mysql-connector::java"
    end
  end

  # PostgreSQL Box
  config.vm.define :postgres do |postgres|

    postgres.vm.box = "precise64"

    postgres.vm.box_url = "http://files.vagrantup.com/precise64.box"

    postgres.vm.provider "virtualbox" do |v|

      v.name = "Liferay PostgreSQL"

      v.customize ["modifyvm", :id, "--memory", 1024]

    end

    postgres.vm.network :private_network, ip: "172.16.40.10"

    postgres.vm.provision :chef_solo do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "database::postgresql"
      chef.add_recipe "postgresql::server"
      chef.add_recipe "liferay::postgresql"

      chef.json = {
        :postgresql => {
          :config => {
            :listen_addresses => "*"
          },
          :pg_hba => [
            {
              :addr => "0.0.0.0/0",
              :db => "all",
              :method => "md5",
              :type => "host",
              :user => "all"
            },
            {
              :addr => "::1/0",
              :db => "all",
              :method => "md5",
              :type => "host",
              :user => "all"
            }
          ],
          :password => {
            :postgres => "autobahn"
          }
        }
      }
    end
  end

  # MySQL Box
  config.vm.define :mysql do |mysql|

    mysql.vm.box = "precise64"

    mysql.vm.box_url = "http://files.vagrantup.com/precise64.box"

    mysql.vm.provider "virtualbox" do |v|
      v.name = "IMSA MySQL"

      v.customize  ["modifyvm", :id, "--memory", 1024]
    end

    mysql.vm.network :private_network, ip: "172.16.40.20"

    mysql.vm.provision :chef_solo do |chef|
      chef.add_recipe "apt"
      chef.add_recipe "database::mysql"
      chef.add_recipe "mysql::server"
      chef.add_recipe "liferay::mysql"

      chef.json = {
        :mysql => {
          :allow_remote_root => true,
          :bind_address => "172.16.40.20",
          :server_debian_password => "autobahn",
          :server_repl_password => "autobahn",
          :server_root_password => "autobahn"
        }
      }
    end
  end

end
