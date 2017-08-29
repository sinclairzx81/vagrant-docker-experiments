# vagrant virtualization of docker containers

The following describes the process of provisioning a local environment to run docker applications in a vm (vagrant) environment. This project documents the installation of virtualbox / vagrant and post installation of both docker and nodejs. We experiment with using nodejs to load up and run new docker images (outside of swarm/stacks) and investigate the level of monitoring and control available via docker. These tests were run against a linux mint 18.1 (Xenial) installation (Ubuntu 16.04 LTS) and trailed hashicorp/precise64, ubuntu/trusty64 and ubuntu/xenial64 vagrant boxes (images).

### install virtualBox / vagrant

The following describes installing the vagrant / virtualbox on the host system. 

source: https://www.godaddy.com/garage/tech/config/install-vagrant-ubuntu-14-04/

```
sudo apt-get install virtualbox
sudo apt-get install vagrant
```

### provision linux precise64 vm

The following with initialize a Vagrantfile in the current working directory. The for the purposes of this project,
we initialized with ```ubuntu/trusty64``` (ubuntu 14.04 LTS).

```bash
$ vagrant init hashicorp/precise64 # ubuntu 12.04 LTS (vagrant default)
$ vagrant init ubuntu/trusty64     # ubuntu 14.04 LTS (preference)
$ vagrant init ubuntu/xenial64     # ubuntu 16.04 LTS (some issues binding to ioctl)
$ vagrant up
```

note: if there is a problem with not being able to locate the virtual box provider, this is likely a version disparity between vagrant 1.8.x and virtualbox 5.1.x. You can try the following workaround to have vagrant resolve the appropriate version of virtualbox.

https://askubuntu.com/questions/867115/vagrant-unable-to-locate-virtualbox 

### vagrant cheatsheet

For reference.
```
Usage: vagrant [options] <command> [<args>]

    -v, --version                    Print the version and exit.
    -h, --help                       Print this help.

Common commands:
     box             manages boxes: installation, removal, etc.
     destroy         stops and deletes all traces of the vagrant machine
     global-status   outputs status Vagrant environments for this user
     halt            stops the vagrant machine
     help            shows the help for a subcommand
     init            initializes a new Vagrant environment by creating a Vagrantfile
     login           log in to HashiCorp's Atlas
     package         packages a running vagrant environment into a box
     plugin          manages plugins: install, uninstall, update, etc.
     port            displays information about guest port mappings
     powershell      connects to machine via powershell remoting
     provision       provisions the vagrant machine
     push            deploys code in this environment to a configured destination
     rdp             connects to machine via RDP
     reload          restarts vagrant machine, loads new Vagrantfile configuration
     resume          resume a suspended vagrant machine
     snapshot        manages snapshots: saving, restoring, etc.
     ssh             connects to machine via SSH
     ssh-config      outputs OpenSSH valid configuration to connect to the machine
     status          outputs status of the vagrant machine
     suspend         suspends the machine
     up              starts and provisions the vagrant environment
     version         prints current and latest Vagrant version
```

### configuring virtualbox networking

The following configures the virtual box instance to run on 192.168.2.88 on the host machine.

```ruby
config.vm.network "public_network", ip: "192.168.2.88"
```

### post installation script

This repository comes with a additional ```bootstrap.sh``` file that installs nodejs and 
docker-ce on the vm this can be configured with.

```ruby
config.vm.provision :shell, path: "bootstrap.sh"
```

### test installation

once installation has completed (following a vagrant up), then ```vagrant ssh``` into the vm and run the following.

```
sudo docker run hello-world
```

### docker cheatsheet

```
Usage:  docker COMMAND

A self-sufficient runtime for containers

Options:
      --config string      Location of client config files (default "/home/vagrant/.docker")
  -D, --debug              Enable debug mode
      --help               Print usage
  -H, --host list          Daemon socket(s) to connect to
  -l, --log-level string   Set the logging level ("debug"|"info"|"warn"|"error"|"fatal") (default "info")
      --tls                Use TLS; implied by --tlsverify
      --tlscacert string   Trust certs signed only by this CA (default "/home/vagrant/.docker/ca.pem")
      --tlscert string     Path to TLS certificate file (default "/home/vagrant/.docker/cert.pem")
      --tlskey string      Path to TLS key file (default "/home/vagrant/.docker/key.pem")
      --tlsverify          Use TLS and verify the remote
  -v, --version            Print version information and quit

Management Commands:
  config      Manage Docker configs
  container   Manage containers
  image       Manage images
  network     Manage networks
  node        Manage Swarm nodes
  plugin      Manage plugins
  secret      Manage Docker secrets
  service     Manage services
  stack       Manage Docker stacks
  swarm       Manage Swarm
  system      Manage Docker
  volume      Manage volumes

Commands:
  attach      Attach local standard input, output, and error streams to a running container
  build       Build an image from a Dockerfile
  commit      Create a new image from a container's changes
  cp          Copy files/folders between a container and the local filesystem
  create      Create a new container
  diff        Inspect changes to files or directories on a container's filesystem
  events      Get real time events from the server
  exec        Run a command in a running container
  export      Export a container's filesystem as a tar archive
  history     Show the history of an image
  images      List images
  import      Import the contents from a tarball to create a filesystem image
  info        Display system-wide information
  inspect     Return low-level information on Docker objects
  kill        Kill one or more running containers
  load        Load an image from a tar archive or STDIN
  login       Log in to a Docker registry
  logout      Log out from a Docker registry
  logs        Fetch the logs of a container
  pause       Pause all processes within one or more containers
  port        List port mappings or a specific mapping for the container
  ps          List containers
  pull        Pull an image or a repository from a registry
  push        Push an image or a repository to a registry
  rename      Rename a container
  restart     Restart one or more containers
  rm          Remove one or more containers
  rmi         Remove one or more images
  run         Run a command in a new container
  save        Save one or more images to a tar archive (streamed to STDOUT by default)
  search      Search the Docker Hub for images
  start       Start one or more stopped containers
  stats       Display a live stream of container(s) resource usage statistics
  stop        Stop one or more running containers
  tag         Create a tag TARGET_IMAGE that refers to SOURCE_IMAGE
  top         Display the running processes of a container
  unpause     Unpause all processes within one or more containers
  update      Update configuration of one or more containers
  version     Show the Docker version information
  wait        Block until one or more containers stop, then print their exit codes
  ```



