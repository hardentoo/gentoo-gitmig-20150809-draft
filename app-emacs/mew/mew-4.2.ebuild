# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emacs/mew/mew-4.2.ebuild,v 1.12 2007/05/20 21:03:55 armin76 Exp $

inherit elisp

DESCRIPTION="Great MIME mail reader for Emacs/XEmacs"
HOMEPAGE="http://www.mew.org/"
SRC_URI="http://www.mew.org/Release/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 ~ppc sparc x86"
IUSE="ssl"
RESTRICT="test"

RDEPEND="ssl? ( net-misc/stunnel )"

SITEFILE=50${PN}-gentoo.el

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	einstall prefix=${D}/usr \
		infodir=${D}/usr/share/info \
		elispdir=${D}/${SITELISP}/${PN} \
		etcdir=${D}/usr/share/${PN} \
		mandir=${D}/usr/share/man/man1 || die "einstall failed"

	elisp-site-file-install "${FILESDIR}/${SITEFILE}"

	dodoc 00api 00changes* 00diff 00readme* 00roadmap mew.dot.* \
		|| die "dodoc failed"
}

pkg_postinst() {
	elisp-site-regen
	elog
	elog "Please refer to /usr/share/doc/${PF} for sample configuration files."
	elog
}

pkg_postrm() {
	elisp-site-regen
}
