
# configure hosts file for our internal network defined by Vagrantfile
echo "
# vagrant environment nodes
192.168.29.2  kafkalab1
192.168.29.3  kafkalab2
192.168.29.4  kafkalab3
" > /etc/hosts
if [[ `hostname` == 'kafkalab1' ]]; then
    sudo yum install -y centos-release-ansible-29 python3 git curl rsync
    sudo yum install -y sshpass
    mkdir ~/.ssh
    touch ~/.ssh/config
    echo "
    Host *
        StrictHostKeyChecking no
    " > ~/.ssh/config
    sudo pip3 install --upgrade pip 
    sudo pip3 install ansible==2.9.5 --user
    echo "export  PATH=\$PATH:/root/.local/bin" >> ~/.profiles 
    echo "export  PATH=\$PATH:/root/.local/bin" >> ~/.bashrc
    source ~/.bashrc
    sudo chmod 400 ~/.ssh/config
    ssh-keygen -b 2048 -t rsa -f ~/sshkey -q -N ""
    cat ~/sshkey.pub >> ~/.ssh/authorized_keys
    # ansible --private-key ~/sshkey -m ping -i localhost, all
    # git clone https://github.com/confluentinc/demo-scene.git
    # git clone https://github.com/confluentinc/examples.git
    # git clone https://github.com/confluentinc/cp-all-in-one.git
    # cd cp-all-in-one/cp-all-in-one
    #Validating ansible
    source ~/.bashrc
    # ansible --version
    cd ~/
    git clone https://github.com/confluentinc/cp-ansible.git
    cd ~/cp-ansible/
elif [[ `hostname` != 'kafkalab1' ]]; then
    sudo yum install -y python3 git curl rsync
    mkdir ~/.ssh
    touch ~/.ssh/config
    echo "
    Host *
        StrictHostKeyChecking no
    " > ~/.ssh/config
fi
# ansible-playbook --private-key ~/sshkey -i hosts_lab.yml zookeeper.yml