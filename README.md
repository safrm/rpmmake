# rpmmake
author:  Miroslav Safr <miroslav.safr@gmail.com>  
web: http://safrm.net/projects/rpmmake  
     https://github.com/safrm/rpmmake  
description: more than fast script to create rpm package inside the git repo without being root  

## content: 
 rpmmake  ................ main linux bash script  
 rpmmake-changelog ....... generates rpm changelog (<my-project>.changes file) from git log  
 rpmmake-debchangelog .... generates debian changelog (debian/changelog file) from git log  
 rpmmake-expect .......... expect wrapper for signing passphrase  
 install.sh .............. executes installation to /urs/bin directory  

## usage1:
<my-project>$ rpmmake  ................... builds rpms from <my-project>/<my-project>.spec in <my-project>/rpm rootdir  
								           requires <my-project>/<my-project>.spec and tags as x.y.z  
## usage2:
rpmmake  /<my-path>/<my-project> ......... builds rpms from /<my-path>/<my-project>/<my-project>.spec in /<my-path>/<my-project>/rpm rootdir  

## usage3: 
<some-other-name>$ rpmmake -b <my-project> ...... project name is taken from argument <my-project> instead of directory name  
                                                  this is important for Hudson/Jenkins slaves because they are using own sub-directorical structure  
## usage4: generate changelogs rpm/deb
./rpmmake-changelog   
first tag: 1.0.4 - e43218284cff9c6c9e69dd17e145805604ecbf66  
rpm changelog for 7 tags updated in ./rpmmake.changes  
  
./rpmmake-debchangelog  
first tag: 1.1.5 - 5bd69b366a3afaf0c2a8b068cf1eed24df1742ea  
debian changelog for 7 tags updated in ./debian/changelog  
  
## usage5: generate changelogs for sub-dir/component  
./rpmmake-changelog -id ./my-component  
  

### check changelog form package
 rpm -qp --changelog ./rpmmake-1.0.5-1.noarch.rpm 
 * Wed May 16 2012 safrrmir-ul000590 <miroslav.safr@gmail.com> - 1.0.5
 - New: changelog scripts added to installation
 - Changes: rpmmake-debchangelog generated right debian/changelog format
 - Fix: rpm changelog tag author New: debian changelog script rpmmake-debchangelog
 - New: Added commits before first tag Changes: default 6 tags, changes file name unified
 ....
  
 ./rpmmake-debchangelog 
 first tag: 1.0.4 - e43218284cff9c6c9e69dd17e145805604ecbf66
 debian changelog for 7 tags updated in ./debian/changelog
  
### check changelog form package
 apt-listchanges ./rpmmake_1.0.5_all.deb  
  or 
 ar p ./s-scripts_1.0.0_all.deb data.tar.gz | tar zx --wildcards "*/changelog.gz" -O | zcat  
  or  
 deblog () { ar p $* data.tar.gz | tar zx --wildcards "*/changelog.gz" -O | zcat; }  
 deblog ./s-scripts_1.0.0_all.deb  
 ...  
  

## install ubuntu:
  1. add release key  
    wget -O - http://safrm.net/releases/Release.key | sudo apt-key add -  
  2. get package  
    wget http://safrm.net/releases/rpmmake/rpmmake_1.0.15_all.deb  
  3.install package  
    sudo dpkg -i ./rpmmake_1.0.15-1_all.deb  
  
## install fedora/RHEL:  
  1. add release key  
    sudo rpm --import http://safrm.net/releases/Release.key  
  2. get package  
    wget http://safrm.net/releases/rpmmake/rpmmake-1.0.15-1.noarch.rpm  
  3.install package  
    sudo rpm -i ./rpmmake-1.0.15-1.noarch.rpm  

