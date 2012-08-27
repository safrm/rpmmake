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
. appver || APP_FULL_VERSION_TAG=NA && APP_BUILD_DATE=`date +'%Y%m%d_%H%M'`


mkdir -p -m 0755 $BINDIR
install -m 0777 -v ./rpmmake  $BINDIR/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=$APP_FULL_VERSION_TAG/" $BINDIR/rpmmake && rm -f $BINDIR/rpmmake.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=$APP_BUILD_DATE/" $BINDIR/rpmmake && rm -f $BINDIR/rpmmake.bkp
install -m 0777 -v ./rpmmake-changelog  $BINDIR/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=$APP_FULL_VERSION_TAG/" $BINDIR/rpmmake-changelog && rm -f $BINDIR/rpmmake-changelog.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=$APP_BUILD_DATE/" $BINDIR/rpmmake-changelog && rm -f $BINDIR/rpmmake-changelog.bkp
install -m 0777 -v ./rpmmake-debchangelog  $BINDIR/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=$APP_FULL_VERSION_TAG/" $BINDIR/rpmmake-debchangelog && rm -f $BINDIR/rpmmake-debchangelog.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=$APP_BUILD_DATE/" $BINDIR/rpmmake-debchangelog && rm -f $BINDIR/rpmmake-debchangelog.bkp
