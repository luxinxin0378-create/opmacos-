#
# LuCI Theme "mac" — macOS 风格主题
# 基于 luci-theme-bootstrap 模板体系 + Mac 设计语言覆盖层
#

include $(TOPDIR)/rules.mk

LUCI_TITLE:=macOS Style Theme
LUCI_DEPENDS:=+luci-base
PKG_LICENSE:=Apache-2.0

# ──────────────────────────────────────────────────────────────
# 重要：构建流水线开关必须写在 include luci.mk 之前！
# luci.mk 末尾的 $(eval $(call BuildPackage,...)) 在 include 时即
# 固化 install/postrm 内容，事后 define 覆盖无效；而 MINIFY 开关
# 用 "?=" 读取，提前定义即可生效。
#
#   - UtMin：把 .ut 预编译成字节码格式 0x02（ucode >= 2026-02-27
#     才能加载），旧 ucode 运行时 loadfile 失败 → LuCI 静默回退
#     原版主题。交付源码模板让设备端现场编译，任何版本兼容。
#   - CssTidy：csstidy 只懂 CSS2.1，会把现代 CSS（自定义属性 /
#     calc() / 渐变 / backdrop-filter 参数）改写破坏
#     （实测 "-apple-system" 字体名被改成 "0"、毛玻璃透明度
#     calc 表达式整条被删），Liquid Glass 材质全部失效。
#   - JsMin：jsmin 可能改写视图脚本语法。
# ──────────────────────────────────────────────────────────────

LUCI_MINIFY_UT:=0
LUCI_MINIFY_CSS:=0
LUCI_MINIFY_JS:=0

define Package/luci-theme-mac/postrm
#!/bin/sh
[ -n "$${IPKG_INSTROOT}" ] || {
	uci -q delete luci.themes.Mac
	uci commit luci
}
endef

include $(TOPDIR)/feeds/luci/luci.mk

# call BuildPackage - OpenWrt buildroot signature
