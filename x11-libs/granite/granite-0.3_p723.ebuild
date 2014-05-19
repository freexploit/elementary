# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit versionator gnome2-utils vala multilib cmake-utils bzr

MY_PV=$(get_version_component_range 3)

DESCRIPTION="A development library for elementary development"
HOMEPAGE="http://launchpad.net/granite"
EBZR_REPO_URI="lp:granite"
EBZR_REVISION=${MY_PV:1}

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="demo nls"

RDEPEND="
	dev-libs/glib:2
	dev-libs/gobject-introspection
	dev-libs/libgee:0.8[introspection]
	>=x11-libs/gtk+-3.4:3[introspection]"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

DOCS=( AUTHORS COPYING NEWS README )

src_prepare() {
	epatch_user

	# Disable building of the demo application (if needed)
	use demo || sed -i '/add_subdirectory (demo)/d' CMakeLists.txt

	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DLIB_INSTALL_DIR=$(get_libdir)
		-DVALA_EXECUTABLE="${VALAC}"
	)

	cmake-utils_src_configure
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
