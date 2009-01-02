# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/gnome2-perl/gnome2-perl-1.041.ebuild,v 1.8 2009/01/02 21:07:57 ssuominen Exp $

inherit perl-module

DESCRIPTION="Perl interface to the 2.x series of the Gnome libraries"
HOMEPAGE="http://gtk2-perl.sourceforge.net/"
SRC_URI="mirror://sourceforge/gtk2-perl/Gnome2-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/libgnomeprint-2
	>=dev-perl/gtk2-perl-1.0
	gnome-base/libgnomeui
	gnome-base/libbonoboui
	>=dev-perl/gnome2-canvas-1.0
	>=dev-perl/glib-perl-1.04
	>=dev-perl/gnome2-vfs-perl-1.0
	dev-lang/perl"
DEPEND="${RDEPEND}
	>=dev-perl/extutils-depends-0.2
	>=dev-perl/extutils-pkgconfig-1.03"

S=${WORKDIR}/Gnome2-${PV}
