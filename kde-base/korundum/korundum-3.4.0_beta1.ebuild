# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/korundum/korundum-3.4.0_beta1.ebuild,v 1.1 2005/01/15 02:24:36 danarmak Exp $

KMNAME=kdebindings
KMCOPYLIB="libsmokeqt smoke/qt libsmokekde smoke/kde"
KMCOMPILEONLY="qtruby"
KM_MAKEFILESREV=1
MAXKDEVER=$PV
KM_DEPRANGE="$PV $MAXKDEVER"
inherit kde-meta

DESCRIPTION="KDE ruby bindings"
KEYWORDS="~x86"
IUSE=""
OLDDEPEND=">=virtual/ruby-1.8 ~kde-base/qtruby-$PV ~kde-base/smoke-3.3.1"
DEPEND=" >=virtual/ruby-1.8
$(deprange-dual $PV $MAXKDEVER kde-base/qtruby)
$(deprange-dual $PV $MAXKDEVER kde-base/smoke)"

PATCHES="$FILESDIR/no-gtk-glib-check.diff"


