#/bin/sh
#more than fast script to create rpm package inside the git repo without being root  - http://safrm.net/projects/rpmmake
#author:  Miroslav Safr <miroslav.safr@gmail.com>
BINDIR=/usr/bin
COMPLETION_DIR=/etc/bash_completion.d
MANDIR=/usr/share/man

#root check
USERID=`id -u`
[ $USERID -eq "0" ] || {
    echo "I cannot continue, you should be root or run it with sudo!"
    exit 0
}

#automatic version
if command -v appver 1>/dev/null 2>&1; then . appver; else APP_SHORT_VERSION=NA ; APP_FULL_VERSION_TAG=NA ; APP_BUILD_DATE=`date +'%Y%m%d_%H%M'`; fi
#test
for TEST in $(  grep -r -l -h "#\!/bin/sh" --exclude-dir=.git . )
do
		sh -n $TEST
		if  [ $? != 0 ]; then
			echo "syntax error in $TEST, exiting.." 
			exit 1
		fi
done

#update documentation
jss-docs-update ./doc 

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
install -m 0777 -v ./rpmmake-expect  $BINDIR/

mkdir -p -m 0755 $COMPLETION_DIR
install -m 0777 -v ./rpmmake_completion  $COMPLETION_DIR/

MANPAGES=`find ./doc/manpages -type f`
install -d -m 755 $MANDIR/man1
install -m 644 $MANPAGES $MANDIR/man1

