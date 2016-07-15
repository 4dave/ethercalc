disk = './secondDisk.vdi'

VAGRANTFILE_API_VERSION = "2"
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.provider "virtualbox" do |vb|
    unless File.exist?(disk)
      vb.customize ["createhd", "--filename", disk, "--size", "25600", "--variant", "Fixed"]
    end
    vb.customize ["storageattach", :id, "--storagectl", "IDE Controller", "--port", "1", "--device", "0", "--type", "hdd", "--medium", disk]
    vb.memory = "2048"
  end
end
