#/bin/sh
#fast script to create rpm package inside the git repo without being root  - https://github.com/safrm/rpmmake
#author:  Miroslav Safr <miroslav.safr@gmail.com>
BINDIR=/usr/bin

sudo mkdir -p -m 0755 $BINDIR
sudo install -m 0777 -v ./rpmmake  $BINDIR/
