
apt install -y man bash-completion zsh htop net-tools

#add users
declare -A usersp
declare -A usersk

usersp=( ["user"]='password'
         ["user2"]='password' 
         ["user3"]='password' 
         ["user4"]='password' 
         ["user5"]='password' 
         ["user6"]='password')
usersk=( ["powerse4"]='sshkey'
         ["user2"]='sshkey' 
         ["user3"]='sshkey' 
         ["user4"]='sshkey'
         ["user5"]='sshkey'        
         ["user6"]='sshkey')



#add user

for user in "${!usersp[@]}"
do
        echo $user

	useradd -m -s /bin/bash -G sudo $user

        echo "$user:${usersp[$user]}" | chpasswd

done

# add keys
for name in "${!usersk[@]}"
do
        echo $name
        mkdir /home/$name/.ssh/
        echo "${usersk[$name]}" >> /home/$name/.ssh/authorized_keys

        chmod 700 /home/$name/.ssh
        chmod 600 /home/$name/.ssh/authorized_keys
        chown $name:$name /home/$name/.ssh
        chown $name:$name /home/$name/.ssh/authorized_keys



done
