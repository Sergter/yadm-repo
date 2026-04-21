Vagrant.configure("2") do |config|
  config.vm.box = "yadm-test"
  config.vm.hostname = "yadm-test-vm"
  config.vm.boot_timeout = 1800

  # Uncomment these if your private box does NOT use the default
  # "vagrant" user and insecure key.
  #
    config.ssh.username = "devuser"
    config.ssh.password = "Yadm!2404#Q7"
    config.ssh.insert_key = true

  config.vm.provider "virtualbox" do |vb|
    vb.name = "yadm-test-vagrant"
    vb.gui = true

    vb.memory = 12478
    vb.cpus = 4

    vb.customize ["modifyvm", :id, "--firmware", "efi"]
    vb.customize ["modifyvm", :id, "--ioapic", "on"]
    vb.customize ["modifyvm", :id, "--graphicscontroller", "vmsvga"]
    vb.customize ["modifyvm", :id, "--vram", "64"]

    vb.customize ["modifyvm", :id, "--mouse", "usbtablet"]

    vb.customize ["modifyvm", :id, "--usbxhci", "on"]

    vb.customize ["modifyvm", :id, "--nictype1", "82540EM"]
    vb.customize ["modifyvm", :id, "--macaddress1", "080027CE5916"]
    vb.customize ["modifyvm", :id, "--nat-localhostreachable1", "on"]

    vb.customize ["modifyvm", :id, "--rtcuseutc", "on"]
    vb.customize ["modifyvm", :id, "--x2apic", "on"]
    vb.customize ["modifyvm", :id, "--pae", "off"]

    # Closest match for the AC'97/AD1980 audio setup in the VBox file
    vb.customize ["modifyvm", :id, "--audio-enabled", "on"]
    vb.customize ["modifyvm", :id, "--audiocontroller", "ac97"]
    vb.customize ["modifyvm", :id, "--audio-driver", "alsa"]

    # Not present in your VBox file; enable only if you want it
    # vb.customize ["modifynvram", :id, "secureboot", "--enable"]
  end
end