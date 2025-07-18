# LOInterpreterKit

LOInterpreterKit 是一款支持 BLE 与本地麦克风的实时语音翻译 iOS SDK，适用于需要双向语音翻译功能的 App 开发场景。

## 特性

* ✅ 支持 BLE 蓝牙设备与本地麦克风音频采集
* ✅ 实时语音识别与翻译
* ✅ 使用 Agora 实现高质量音频通话
* ✅ 网络层基于 Moya + Combine 构建
* ✅ 支持私有化部署（依赖私有 CocoaPods 源）

## 安装

本 SDK 依赖私有仓库 `ToallSpecs`。

在 Podfile 中添加：

```ruby
source 'https://github.com/TOALL-GIT/LOInterpreterKit.git'
source 'https://github.com/CocoaPods/Specs.git'

pod 'LOInterpreterKit', '~> 0.1.22'
```

### 子模块说明

* `LOInterpreterKit/Core`：包含核心定义和接口
* `LOInterpreterKit/WithPod`：包含 BLE、Opus 编解码支持

## 使用方法

```swift
import LOInterpreterKit

let config = LOInterpreterConfig()
let interpreter = LOInterpreterCore(config: config)
interpreter.start()
```

> ⚠️ 详细使用方法请参考项目内 Demo 或文档说明。

## 依赖库

* [Moya](https://github.com/Moya/Moya) \~> 15.0
* [AgoraAudio\_iOS](https://www.agora.io) \~> 4.5.2
* [SQLite.swift](https://github.com/stephencelis/SQLite.swift)
* 私有库：LOBleKit、LOLibopus、LONetworkKit

## 作者

👤 **wayne**
📧 [zhouzhiwei@lian-o.com](mailto:zhouzhiwei@lian-o.com)

## License

MIT License. See `LICENSE` file for details.
