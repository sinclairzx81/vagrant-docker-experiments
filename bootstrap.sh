################################################
# DOCKER & NODE PROVISIONING SCRIPTS
#
# Installs nodejs 8.x and docker-ce.
################################################


#
# update apt repositories
#
sudo apt-get update

#
# install curl
#
sudo apt-get install -y curl

#
# install nodejs
#
# source: https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions
#
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential


#
# Install docker (prerequistes)
#
# source: https://docs.docker.com/engine/installation/linux/docker-ce/ubuntu/#install-using-the-repository
#
sudo apt-get install -y linux-image-extra-$(uname -r) linux-image-extra-virtual
sudo apt-get install -y apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

#
# Install docker-ce
#
sudo apt-get update
sudo apt-get install -y docker-ce

