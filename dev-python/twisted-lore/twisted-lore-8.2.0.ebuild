# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/twisted-lore/twisted-lore-8.2.0.ebuild,v 1.2 2009/09/06 20:47:21 idl0r Exp $

MY_PACKAGE=Lore

inherit twisted versionator

DESCRIPTION="Twisted documentation system"

KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND="=dev-python/twisted-$(get_version_component_range 1-2)*
	dev-python/twisted-web"
RDEPEND="${DEPEND}"

IUSE=""
