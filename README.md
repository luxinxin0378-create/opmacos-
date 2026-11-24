# LuCI Theme "mac" — macOS 风格路由器主题

**OpenWrt / ponwrt LuCI 的 macOS 风格主题**：磨砂玻璃顶栏 + 大圆角卡片 + 苹果蓝胶囊按钮，把路由器后台变成苹果味儿。

基于官方 `luci-theme-bootstrap` 模板体系（现代 client-side 渲染 LuCI）+ macOS 设计语言覆盖层，纯 CSS 皮肤包，不碰任何底层代码。

## 特性

| 元素 | 实现 |
|---|---|
| 字体 | SF Pro 系统字体栈（-apple-system → PingFang SC 兜底） |
| 顶栏 | **磨砂玻璃**（backdrop-filter: saturate blur），sticky 跟随滚动 |
| 卡片 | 16px 大圆角 + 柔和双层阴影 + 细分割线（#f5f5f7 底 / 白卡片） |
| 主色 | 苹果蓝 `#0071e3`（暗色 `#0a84ff`） |
| 按钮 | 胶囊圆角，主要操作蓝底白字，按压微缩反馈 |
| 标签页 | macOS 分段控件（灰槽 + 白色浮起选中块） |
| 下拉菜单 | 磨砂浮层 + 悬停苹果蓝填充 |
| 表格 | 无边框 + 行悬停淡蓝高亮 + 全大写小号表头 |
| 暗色模式 | **跟随系统**（prefers-color-scheme，全套配色变量自动切换） |

覆盖范围：顶栏/导航/下拉、内容卡片、表单控件、按钮体系（primary/negative/reset/disabled）、表格、标签页、提示框（warning/error/info）、徽标、进度条、滚动条、页脚、登录页。

## 安装（编译集成）

**方式一：clone 拷入 buildroot（推荐）**

```sh
git clone https://github.com/luxinxin0378-create/opmacos-.git /tmp/luci-theme-mac
cp -a /tmp/luci-theme-mac <buildroot>/package/luci-theme-mac
rm -rf <buildroot>/package/luci-theme-mac/.git
make menuconfig   # LuCI → Themes → luci-theme-mac 选上
```

**方式二：固件构建脚本内自动拉取**（适合 CI）

```sh
git clone --depth 1 https://github.com/luxinxin0378-create/opmacos-.git /tmp/luci-theme-mac
cp -a /tmp/luci-theme-mac "$SRC/package/luci-theme-mac"
# seed/config 里加：CONFIG_PACKAGE_luci-theme-mac=y
```

编译出的固件默认启用 Mac 主题（包内 uci-defaults 自动注册并切换），原有主题保留可随时在「系统 → 语言和界面」切回。

## 启用 / 切换

刷入含主题固件后自动生效；手动切换：**LuCI → 系统 → 系统 → 语言和界面（外观）→ Mac**。

## 兼容性

- 现代 LuCI（ucode 模板、client-side 渲染）：OpenWrt 23.05+ / main / ponwrt / immortalwrt
- 仅依赖 `luci-base`，无其他组件
- 含移动端样式（mobile.css），小屏自动降级

## 文件结构

```
├── Makefile                                  # luci.mk 主题包定义 + postrm 反注册
├── ucode/template/themes/mac/
│   ├── header.ut / footer.ut / sysauth.ut   # 页面骨架（源自官方 bootstrap）
├── htdocs/luci-static/mac/
│   ├── cascade.css                           # bootstrap 基础样式 + Mac 覆盖层
│   ├── mobile.css                            # 移动端
│   ├── logo.svg / logo_48.png                # 站标
├── htdocs/luci-static/resources/view/mac/
│   └── sysauth.js                            # 登录页视图
└── root/etc/uci-defaults/30_luci-theme-mac   # 默认启用注册
```

## 许可

Apache-2.0（页面骨架继承 OpenWrt luci-theme-bootstrap 许可）
