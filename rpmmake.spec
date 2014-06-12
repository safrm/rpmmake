%define APP_BUILD_DATE %(date +'%%Y%%m%%d_%%H%%M')

Name:       rpmmake
Summary:    Create rpm package inside the git repo without beeing root 
Version:    1.0.0
Release:    1
Group:      Development/Tools
License:    LGPL v2.1
BuildArch:  noarch
URL:        http://safrm.net/projects/rpmmake 
Vendor:     Miroslav Safr <miroslav.safr@gmail.com>
Source0:    %{name}-%{version}.tar.bz2
Autoreq: on
Autoreqprov: on
Requires:  expect
Requires:  rpm-sign
BuildRequires:  appver >= 1.1.1
BuildRequires: jenkins-support-scripts >= 1.2.3

%description
More than fast script to create rpm package inside the git repo without beeing root 

%prep
%setup -c -n ./%{name}-%{version}

%build
jss-docs-update ./doc -sv %{version} 

%install
mkdir -p %{buildroot}/usr/bin
install -m 755 ./rpmmake %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake && rm -f %{buildroot}/usr/bin/rpmmake.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=%{APP_BUILD_DATE}/" %{buildroot}/usr/bin/rpmmake && rm -f %{buildroot}/usr/bin/rpmmake.bkp
install -m 755 ./rpmmake-changelog %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake-changelog && rm -f %{buildroot}/usr/bin/rpmmake-changelog.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=%{APP_BUILD_DATE}/" %{buildroot}/usr/bin/rpmmake-changelog && rm -f %{buildroot}/usr/bin/rpmmake-changelog.bkp
install -m 755 ./rpmmake-debchangelog %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake-debchangelog && rm -f %{buildroot}/usr/bin/rpmmake-debchangelog.bkp
sed -i".bkp" "1,/^VERSION_DATE=/s/^VERSION_DATE=.*/VERSION_DATE=%{APP_BUILD_DATE}/" %{buildroot}/usr/bin/rpmmake-debchangelog && rm -f %{buildroot}/usr/bin/rpmmake-debchangelog.bkp
install -m 755 ./rpmmake-expect %{buildroot}/usr/bin/

mkdir -p -m 0755 %{buildroot}%{_sysconfdir}/bash_completion.d
install -m 0777 -v ./rpmmake_completion %{buildroot}%{_sysconfdir}/bash_completion.d

#documentation
MANPAGES=`find ./doc/manpages -type f`
install -d -m 755 %{buildroot}%{_mandir}/man1
install -m 644 $MANPAGES %{buildroot}%{_mandir}/man1

%clean
rm -fr %{buildroot}

%check
for TEST in $(  grep -r -l -h "#\!/bin/sh" . )
do
		sh -n "$TEST"
		if  [ $? != 0 ]; then
			echo "syntax error in $TEST, exiting.." 
			exit 1
		fi
done

%files
%defattr(-,root,root,-)
%{_bindir}/rpmmake
%{_bindir}/rpmmake-changelog
%{_bindir}/rpmmake-debchangelog
%{_bindir}/rpmmake-expect

%{_sysconfdir}/bash_completion.d/rpmmake_completion

#man pages
%{_mandir}/man1/rpmmake.1*
%{_mandir}/man1/rpmmake-changelog.1*
%{_mandir}/man1/rpmmake-debchangelog.1*
%{_mandir}/man1/rpmmake-expect.1*


