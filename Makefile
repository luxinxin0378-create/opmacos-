#
# LuCI Theme "mac" — macOS 风格主题
# 基于 luci-theme-bootstrap 模板体系 + Mac 设计语言覆盖层
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=macOS Style Theme
LUCI_DEPENDS:=+luci-base
PKG_LICENSE:=Apache-2.0

define Package/luci-theme-mac/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Mac
	uci commit luci
}
endef

include $(TOPDIR)/feeds/luci/luci.mk

# Override luci.mk default install: keep .ut as plain source templates.
# The stock install applies UtMin precompilation (CONFIG_LUCI_UTMIN default y),
# which embeds bytecode with format byte 0x02 (ucode >= 2026-02-27). On devices
# whose ucode runtime predates that format, loadfile() fails and LuCI silently
# falls back to the first compilable theme - the mac theme never renders.
# Shipping source templates lets the device-side ucode compile them on the fly,
# which works with any ucode version (this is how 3rd-party themes like argon do it).
define Package/luci-theme-mac/install
	$(INSTALL_DIR) $(1)$(UCODE_LIBRARYDIR)
	cp -pR $(PKG_BUILD_DIR)/ucode/* $(1)$(UCODE_LIBRARYDIR)/
	$(INSTALL_DIR) $(1)$(HTDOCS)
	cp -pR $(PKG_BUILD_DIR)/htdocs/* $(1)$(HTDOCS)/
	$(INSTALL_DIR) $(1)/
	cp -pR $(PKG_BUILD_DIR)/root/* $(1)/
endef

# call BuildPackage - OpenWrt buildroot signature
