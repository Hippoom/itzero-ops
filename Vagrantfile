# coding: utf-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

$yum_repo_script = <<JDK_SCRIPT
  sudo yum install -y java-1.8.0-openjdk java-1.8.0-openjdk-devel
JDK_SCRIPT

$base_script = <<BASE_SCRIPT
  sudo sed -i '/LANG=/c LANG="en_US.UTF-8"' /etc/sysconfig/i18n
  source /etc/sysconfig/i18n
  sudo sed -i '/=enforcing/c SELINUX=disabled' /etc/selinux/config
BASE_SCRIPT

Vagrant.configure(2) do |config|
  if Vagrant.has_plugin?("vagrant-cachier")
    # Configure cached packages to be shared between instances of the same base box.
    # More info on http://fgrehm.viewdocs.io/vagrant-cachier/usage
    config.cache.scope = :box
  end

  cluster = {
      "uat" => {
          :cpus => 1,
          :mem => 1024,
          :ip => "192.168.47.11",
          :box => "centos6.6",
          :hostname => "itzero.uat",
          :shells => [$base_script, $yum_repo_script]
      }
  }

  cluster.each_with_index do |(hostname, info), index|
    config.vm.define hostname do |host|
      host.vm.box = info[:box]
      host.vm.hostname = info[:hostname]
      host.vm.provider "virtualbox" do |v|
        v.name = "#{hostname.downcase}"
        v.cpus = info[:cpus]
        v.memory = info[:mem]
      end
      host.vm.network "private_network", ip: info[:ip] if info[:ip]
      info[:shells].each do |shell|
        host.vm.provision "shell", inline: shell
      end if info[:shells]
    end
  end
end
