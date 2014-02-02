# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  config.omnibus.chef_version = :latest

  config.berkshelf.enabled = true

  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  # Liferay Box
  config.vm.define :liferay do |liferay|

    liferay.vm.box = "opscode-precise64-provisionerless"

    liferay.vm.box_url = "https://opscode-vm-bento.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

    liferay.vm.provider "virtualbox" do |v|
      v.name = "Liferay"

      v.customize ["modifyvm", :id, "--memory", 2048]
    end

    liferay.vm.network :private_network, ip: "172.16.30.10"

    liferay.vm.provision :chef_solo do |chef|
      chef.add_recipe "liferay"
      chef.add_recipe "mysql-connector::java"

      chef.json = {
        :java => {
          :install_flavor => "oracle",
          :jdk_version => "6",
          :java_home => "/usr/lib/default-java",
          :oracle => {
            :accept_oracle_download_terms => true
          }
        }
      }
    
    end
  end

  # PostgreSQL Box
  config.vm.define :postgres do |postgres|

    postgres.vm.box = "opscode-precise64-provisionerless"

    postgres.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

    postgres.vm.provider "virtualbox" do |v|

      v.name = "Liferay PostgreSQL"

      v.customize ["modifyvm", :id, "--memory", 1024]

    end

    postgres.vm.network :private_network, ip: "172.16.40.10"

    postgres.vm.provision :chef_solo do |chef|
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

    mysql.vm.box = "opscode-precise64-provisionerless"

    mysql.vm.box_url = "https://opscode-vm.s3.amazonaws.com/vagrant/opscode_ubuntu-12.04_provisionerless.box"

    mysql.vm.provider "virtualbox" do |v|
      v.name = "Liferay MySQL"

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
