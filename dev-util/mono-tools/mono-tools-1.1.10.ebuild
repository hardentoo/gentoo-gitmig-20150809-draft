# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/mono-tools/mono-tools-1.1.10.ebuild,v 1.2 2005/11/14 15:42:36 herbs Exp $

inherit mono multilib

DESCRIPTION="Set of useful Mono related utilities"
HOMEPAGE="http://www.mono-project.com/"
SRC_URI="http://www.go-mono.com/sources/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/mono
	>=dev-util/monodoc-${PV}
	=dev-dotnet/gtk-sharp-1.0*
	=dev-dotnet/gnome-sharp-1.0*
	=dev-dotnet/glade-sharp-1.0*
	=dev-dotnet/gtkhtml-sharp-1.0*
	=dev-dotnet/gconf-sharp-1.0*
	<dev-dotnet/gecko-sharp-0.10"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Install all our .dlls under $(libdir), not $(prefix)/lib
	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e 's:$(prefix)/lib:$(libdir):' \
			${S}/{asn1view/gtk,docbrowser,gnunit/src}/Makefile.am \
			|| die "sed failed"
		sed -i -e 's:$prefix/lib:@libdir@:' \
			${S}/docbrowser/monodoc.in || die "sed failed"

		aclocal || die "aclocal failed"
		automake || die "automake failed"
	fi
}

src_compile() {
	econf || die
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc ChangeLog README
}
