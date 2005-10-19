# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/monodoc/monodoc-1.0.6.ebuild,v 1.7 2005/10/19 16:38:24 latexer Exp $

inherit mono

DESCRIPTION="Documentation for mono's .Net class library"
HOMEPAGE="http://www.go-mono.com"
SRC_URI="http://www.go-mono.com/archive/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~amd64"
IUSE=""
DEPEND=">=dev-lang/mono-1.0
		>=dev-dotnet/gtk-sharp-${PV}
		>=dev-dotnet/glade-sharp-${PV}
		>=dev-dotnet/gtkhtml-sharp-${PV}
		=dev-dotnet/gtk-sharp-1.0*
		=dev-dotnet/glade-sharp-1.0*
		=dev-dotnet/gtkhtml-sharp-1.0*"

src_compile() {
	econf || die
	emake -j1 || die "make failed"
}

src_install() {
	make DESTDIR=${D} install || die
}

pkg_postinst() {
	einfo
	einfo "If you'd like to use monodoc's index section, please run"
	einfo "'monodoc --make-index' as root before running monodoc."
	einfo
}
