# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION=0.20

inherit vala cmake-utils bzr

DESCRIPTION="Configure various aspects of the Pantheon desktop environment using Switchboard."
HOMEPAGE="http://launchpad.net/switchboard-plug-pantheon-shell"
EBZR_REPO_URI="lp:switchboard-plug-pantheon-shell"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls"

RDEPEND="
	x11-libs/granite
	>=pantheon-base/switchboard-2"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	use nls || sed -i '/add_subdirectory (po)/d' CMakeLists.txt

	cmake-utils_src_prepare
	vala_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
	)
	cmake-utils_src_configure
}