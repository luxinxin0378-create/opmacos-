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

# call BuildPackage - OpenWrt buildroot signature
