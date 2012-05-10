#/bin/sh
#fast script to create rpm package inside the git repo without being root  - https://github.com/safrm/rpmmake
#author:  Miroslav Safr <miroslav.safr@gmail.com>
BINDIR=/usr/bin

#root check
USERID=`id -u`
[ $USERID -eq "0" ] || { 
    echo "I cannot continue, you should be root or run it with sudo!"
    exit 0
}

#automatic version 
. appver


mkdir -p -m 0755 $BINDIR
install -m 0777 -v ./rpmmake  $BINDIR/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=$APP_FULL_VERSION_TAG/" $BINDIR/rpmmake && rm -f $BINDIR/rpmmake.bkp
