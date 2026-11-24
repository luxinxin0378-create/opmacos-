# LuCI Theme "mac" — Liquid Glass 主题（iOS 27 / macOS 27 风格）

**OpenWrt / ponwrt LuCI 的液态玻璃主题**：按 iOS 27 的 Liquid Glass 设计语言打造——强扩散玻璃、暗化边缘、镜面高光、三档透明度。

基于官方 `luci-theme-bootstrap` 模板体系（现代 client-side 渲染 LuCI）+ Liquid Glass 覆盖层，纯 CSS 皮肤包，不碰任何底层代码。

## 特性（v2 · 对标 iOS 27）

| iOS 27 特性 | 主题实现 |
|---|---|
| 强扩散玻璃材质 | backdrop-filter: blur(26px) saturate(200%)，背景三团柔和色斑供玻璃透色折射 |
| 暗化边缘（darkened edge） | 所有玻璃层 1px 暗边框 + 内圈暗 inset，层次分离更清晰 |
| 更亮镜面高光 | 玻璃层顶部 inset 高光 + 内圈微亮描边 |
| 透明度滑块 | `:root` 里 `--lg-alpha` 三档可调（见下） |
| 滚动统一顶栏 | 内容滚入玻璃下方时顶栏自动加实保证可读性（scroll-driven animation） |
| 暗色模式 | 跟随系统切换深色玻璃（#0d0d0f 底 + 深色玻璃层） |

另有：20px 大圆角玻璃卡片、玻璃胶囊按钮、iOS 分段控件标签页、玻璃凹陷输入框、玻璃提示框与徽标。

## 透明度三档（对应 iOS 27 设置里的滑块）

改 `htdocs/luci-static/mac/cascade.css` 顶部 `:root` 一行：

```css
--lg-alpha: .48;  /* 超清晰 ultra-clear */
--lg-alpha: .66;  /* 均衡 balanced ← 默认 */
--lg-alpha: .88;  /* 完全着色 fully-tinted */
```

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
- 玻璃效果需浏览器支持 backdrop-filter（Chrome/Edge/Safari 全支持）；不支持时自动降级为半透明实色
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
