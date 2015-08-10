# Scoreboard Vagrant

## Requirements

* Vagrant
* VirtualBox

## Deployment [mbaMission]

1. Clone this repository `git clone git@github.com:ShinKaiRyuu/scotch-box.git`
2. `cd scotch-box`
3. Init scoreboard submodule `git submodule init` (Make sure you have access rights to read scoreboard repo)
4. Update scoreboard module `git submodule update` 
5. Vagrant Up `vagrant up`
6. Put `192.168.33.10 mbamission.scoreboard-qa.selfip.com1` into your hosts file
