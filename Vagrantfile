Vagrant.configure("2") do |config|

  config.vm.box       = 'precise64'
  config.vm.box_url   = 'http://files.vagrantup.com/precise64.box'
  config.vm.hostname = 'rails-starter-box'

  config.vm.network :forwarded_port, guest: 3000, host: 3000

  config.vm.provision :puppet,
    :manifests_path => 'puppet/manifests',
    :module_path    => 'puppet/modules'
end
