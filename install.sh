#/bin/sh
#more than fast script to create rpm package inside the git repo without being root 
#web: http://safrm.net/projects/rpmmake
#author:  Miroslav Safr <miroslav.safr@gmail.com>
. appver-installer

appver_basic_scripts_test

$MKDIR_755 $BINDIR
$INSTALL_755 ./rpmmake  $BINDIR
appver_update_version_and_date $BINDIR/rpmmake
$INSTALL_755 ./rpmmake-changelog  $BINDIR
appver_update_version_and_date $BINDIR/rpmmake-changelog
$INSTALL_755 ./rpmmake-debchangelog  $BINDIR
appver_update_version_and_date $BINDIR/rpmmake-debchangelog
$INSTALL_755 ./rpmmake-expect  $BINDIR

$MKDIR_755 $COMPLETION_DIR
$INSTALL_755 ./rpmmake_completion  $COMPLETION_DIR

