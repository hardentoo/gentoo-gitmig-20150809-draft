# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/solfege/solfege-3.6.0.ebuild,v 1.1 2006/10/08 06:58:05 matsuu Exp $

IUSE="oss"

inherit python eutils

DESCRIPTION="GNU Solfege is a program written to help you practice ear training."
HOMEPAGE="http://www.solfege.org"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND=">=dev-lang/python-2.3
	>=x11-libs/gtk+-2.6
	>=dev-python/pygtk-2.6
	>=gnome-extra/gtkhtml-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	=dev-lang/swig-1.3*
	sys-devel/gettext
	sys-apps/texinfo
	dev-libs/libxslt
	sys-apps/sed
	=app-text/docbook-xsl-stylesheets-1.6*"

src_compile() {
	# Try to figure out where is this damn stylesheet
	local xslloc=$( ls /usr/share/sgml/docbook/xsl-stylesheets-1.6*/html/chunk.xsl | tail -n 1 )
	[ -n "$xslloc" ] || die "XSL stylesheet not found"

	econf --enable-docbook-stylesheet=${xslloc} \
		$(use_enable oss oss-sound) || die "Configuration failed."

	emake || die "Compilation failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed."
	dodoc AUTHORS changelog FAQ README TODO
}

