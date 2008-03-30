# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/gramps/gramps-3.0.0.ebuild,v 1.1 2008/03/30 15:58:04 opfer Exp $

WANT_AUTOCONF="latest"
WANT_AUTOMAKE="latest"

inherit autotools eutils gnome2

DESCRIPTION="Genealogical Research and Analysis Management Programming System"
HOMEPAGE="http://www.gramps-project.org/"
SRC_URI="mirror://sourceforge/gramps/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND=">=dev-lang/python-2.5
	>=dev-python/pygtk-2.10.0
	>=dev-python/gnome-python-2.6
	>=app-text/gnome-doc-utils-0.6.1
	media-gfx/graphviz
	>=dev-python/reportlab-1.11"
DEPEND="${RDEPEND}
	sys-devel/gettext
	app-text/scrollkeeper
	virtual/libiconv
	dev-util/pkgconfig"

DOCS="NEWS README TODO"

pkg_setup() {
	if ! built_with_use 'dev-lang/python' berkdb ; then
		eerror "You need to install python with Berkely Database support."
		eerror "Add 'dev-lang/python berkdb' to /etc/portage/package.use "
		eerror "and then re-emerge python."
		die "berkdb support missing from gnome"
	fi

	G2CONF="${G2CONF} --disable-mime-install"
}
