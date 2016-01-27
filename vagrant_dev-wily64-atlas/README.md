*"yo dawg, I heard you like Vagrant so I put Vagrant in your Vagrant so you can develop Vagrant while you use Vagrant"*

# About

Creates a development environment for developing Vagrant plugins, in particular `vagrant-aws` which it expects to have been cloned to `/vagrant/`.


So start by deploying and connecting to this environment:
```bash
# NOTE: you need to have cloned your fork, if not then at least clone from upstream:
# git clone git@github.com:mitchellh/vagrant-aws.git

vagrant up
vagrant ssh
```

Then to work on the plugin:
```bash
# add the AWS dummy box
cd /vagrant/vagrant-aws/
bundle exec vagrant box add dummy dummy.box
```

Then edit the Vagrantfile to something like this one:
```ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :


Vagrant.require_plugin "vagrant-aws"

Vagrant.configure(2) do |config|
  # AWS dummy box
  config.vm.box = "dummy"

  config.vm.provider :aws do |aws, override|
    aws.access_key_id = "AKI_KEY_ID..."
    aws.secret_access_key = "SECRET_PASSWORD..."
    aws.region = "eu-west-1"
    # if your default SG does not allow for SSH then you need to specify it here
    #aws.security_groups = ['sg-123...']

    aws.ami = "ami-e31a6594"
    aws.instance_type = "t2.micro"
    aws.keypair_name = "YOUR_KEYPAIR_NAME_IN_AWS"

    override.ssh.username = "admin"
    override.ssh.private_key_path = "DOWNLOADED_PEM_FILE_FOR_KEYPAIR_NAME"
  end

end

```

To run Vagrant:
```bash
# use bundle to execute Vagrant
bundle exec vagrant up --provider=aws
# and to connect
bundle exec vagrant ssh
# and to terminate the instance
bundle exec vagrant destroy -f
```


