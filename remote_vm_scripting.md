# Multi VM Scripts Setup (how to run scripts on other VM's from your VM)

## SCRIPT_VM = 192.168.20.11

## REMOTE_VM = 192.168.20.12

ssh to the SCRIPT_VM and run the following commands below
```
$ vim /etc/hosts
192.168.20.12 REMOTE_VM
```

ssh to the REMOTE_VM and run the following commands below
```
$ vim /etc/hosts
REMOTE_VM
$ hostname REMOTE_VM
$ vim /etc/ssh/sshd_config
PasswordAuthentication yes
$ systemctl restart ssh
$ adduser devops
$ passwd devops
$ visudo
devops  ALL=(ALL:ALL) NOPASSWD: ALL
```

finally ssh SCRIPT_VM and test the command below
```
$ ssh devops@REMOTE_VM uptime
```
enter your password and if the command works then you have a successfull remote-connection to the VM
