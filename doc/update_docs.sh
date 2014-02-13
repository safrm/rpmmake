#!/bin/sh
#web: http://safrm.net/projects/rpmmake
#author: Miroslav Safr <miroslav.safr@gmail.com> 
#first argument passes release version for releasing package builds

XSLTPROC=/usr/bin/xsltproc 
if [ ! -e $MANXSL ]; then
	echo "$XSLTPROC does not exist, exiting.."
	exit 1
fi

MANXSL=/usr/share/xml/docbook/stylesheet/docbook-xsl/manpages/docbook.xsl
if [ ! -e $MANXSL ]; then
	MANXSL=http://docbook.sourceforge.net/release/xsl/current/manpages/docbook.xsl
fi

HTMLXSL=/usr/share/xml/docbook/stylesheet/docbook-xsl/html/docbook.xsl
if [ ! -e $MANXSL ]; then
	MANXSL=http://docbook.sourceforge.net/release/xsl/current/html/docbook.xsl
fi

#automatic version 
if command -v appver &>/dev/null; then . appver $1; else APP_SHORT_VERSION=NA ; APP_FULL_VERSION_TAG=NA ; APP_BUILD_DATE=`date +'%Y%m%d_%H%M'`; fi

TEMP_DIR=./tmp
rm -fr $TEMP_DIR && mkdir $TEMP_DIR
#update version and date
for PAGEXML in $(  find . -type f -name "*1.xml" )
do
    cp $PAGEXML $TEMP_DIR/
    sed -i".bkp" "1,/<productnumber>/s/<productnumber>.*/<productnumber>$APP_SHORT_VERSION_TAG<\/productnumber>/" $TEMP_DIR/$PAGEXML  && rm -f $TEMP_DIR/$PAGEXML.bkp
    sed -i".bkp" "1,/<\/date>/s/<date>.*/<date>$APP_BUILD_DATE<\/date>/" $TEMP_DIR/$PAGEXML  && rm -f $TEMP_DIR/$PAGEXML.bkp
done

#generate man and html pages
for PAGEXML in $(  find ./tmp -type f -name "*1.xml" )
do
	PAGENAME=`basename $PAGEXML .1.xml`
	$XSLTPROC -o ./htmlpages/$PAGENAME.html $HTMLXSL $PAGEXML
	$XSLTPROC -o ./manpages/$PAGENAME.1 $MANXSL $PAGEXML
done
