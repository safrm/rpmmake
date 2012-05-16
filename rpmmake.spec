%define buildroot %{_topdir}/%{name}-%{version}-root

Name:       rpmmake
Summary:    create rpm package inside the git repo without beeing root 
Version:    1.0.0
Release:    1
Group:      System/Libraries
License:    LGPL v2.1
BuildArch:  noarch
URL:        https://github.com/safrm/rpmmake
Vendor:     Miroslav Safr <miroslav.safr@gmail.com>
Source0:    %{name}-%{version}.tar.bz2
Autoreq: on
Autoreqprov: on
BuildRoot: %{buildroot}

%description
fast script to create rpm package inside the git repo without beeing root 



%prep
%setup -c -n ./%{name}-%{version}
# >> setup
# << setup

%build
# >> build pre
#qmake install_prefix=/usr
# << build pre
#make %{?jobs:-j%jobs}

# >> build post
# << build post

%install
rm -fr $RPM_BUILD_ROOT
# >> install pre
export INSTALL_ROOT=$RPM_BUILD_ROOT
# << install pre 
#make install
mkdir -p %{buildroot}/usr/bin
install -m 755 ./rpmmake %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake && rm -f %{buildroot}/usr/bin/rpmmake.bkp
install -m 755 ./rpmmake-changelog %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake-changelog && rm -f %{buildroot}/usr/bin/rpmmake-changelog.bkp
install -m 755 ./rpmmake-debchangelog %{buildroot}/usr/bin/
sed -i".bkp" "1,/^VERSION=/s/^VERSION=.*/VERSION=%{version}/" %{buildroot}/usr/bin/rpmmake-debchangelog && rm -f %{buildroot}/usr/bin/rpmmake-debchangelog.bkp

# >> install post
# << install post






%files
%defattr(-,root,root,-)
# >> files
%{_bindir}/rpmmake
%{_bindir}/rpmmake-changelog
%{_bindir}/rpmmake-debchangelog
# << files


