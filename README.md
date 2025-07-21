# LOInterpreterKit 使用文档
`LOInterpreterKit` 是一个支持多语言语音翻译的 SDK，支持麦克风与 BLE 音频输入，内部集成了声网 (Agora) 音频通道和流式翻译机制，并结合数据库实现会话缓存和记录。

---

## 功能简介
+ 支持麦克风和蓝牙（BLE）音频输入
+ 实时语音识别与翻译
+ 支持多语言配置
+ 提供 Combine 风格的数据流监听
+ 支持会话缓存与翻译记录存储

---

## 安装方式
目前仅支持通过 CocoaPods 方式集成：

```ruby
pod 'LOInterpreterKit', :git => 'https://your.repo.url/LOInterpreterKit.git'
```

---

## 配置说明 `LOInterpreterConfig`
使用 SDK 前，请先初始化配置结构体 `LOInterpreterConfig`：

```swift
let config = LOInterpreterConfig(
    audioInputMode: .microphone,
    userId: 123456,
    sourceLanguage: "zh",
    targetLanguage: "en",
    speechLanguage: "en",
    single: true,
    type: .doubleTranslate,
    timeout: 3600,
    mute: true,
    conversationPrefix: "对话标题",
    domain: "https://your.domain.com",
    dynamicDomain: "https://dynamic.domain.com"
)
```

### <font style="color:rgb(0, 0, 0);">参数字段说明</font>
| <font style="color:rgb(0, 0, 0);">字段名</font> | <font style="color:rgb(0, 0, 0);">类型</font> | <font style="color:rgb(0, 0, 0);">说明</font> |
| --- | --- | --- |
| <font style="color:rgb(0, 0, 0);">audioInputMode</font> | <font style="color:rgb(0, 0, 0);">LOAudioInputMode</font> | <font style="color:rgb(0, 0, 0);">音频输入源，支持</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">.microphone</font>`<br/><font style="color:rgb(0, 0, 0);">（麦克风）或</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">.ble</font>`<br/><font style="color:rgb(0, 0, 0);">（蓝牙）</font> |
| `<font style="color:rgb(0, 0, 0);">userId</font>` | `<font style="color:rgb(0, 0, 0);">Int</font>` | <font style="color:rgb(0, 0, 0);">用户唯一标识，用于声网频道识别</font> |
| `<font style="color:rgb(0, 0, 0);">sourceLanguage</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">源语言代码（如 "zh" 表示中文）</font> |
| `<font style="color:rgb(0, 0, 0);">targetLanguage</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">目标语言代码（如 "en" 表示英文）</font> |
| `<font style="color:rgb(0, 0, 0);">speechLanguage</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">语音合成（TTS）语言代码，用于语音播放</font> |
| `<font style="color:rgb(0, 0, 0);">single</font>` | `<font style="color:rgb(0, 0, 0);">Bool?</font>` | <font style="color:rgb(0, 0, 0);">是否单轮翻译模式，默认</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">true</font>`<br/><font style="color:rgb(0, 0, 0);">，设置为</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">false</font>`<br/><font style="color:rgb(0, 0, 0);"> </font><font style="color:rgb(0, 0, 0);">表示多轮对话模式</font> |
| `<font style="color:rgb(0, 0, 0);">type</font>` | `<font style="color:rgb(0, 0, 0);">LOInterpretationType</font>` | <font style="color:rgb(0, 0, 0);">翻译类型，可选</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">.doubleTranslate</font>`<br/><font style="color:rgb(0, 0, 0);">,</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">.singTranslate</font>`<br/><font style="color:rgb(0, 0, 0);"> </font><font style="color:rgb(0, 0, 0);">或自定义类型</font> |
| `<font style="color:rgb(0, 0, 0);">timeout</font>` | `<font style="color:rgb(0, 0, 0);">TimeInterval</font>` | <font style="color:rgb(0, 0, 0);">无响应超时时间（单位：秒），默认 3600 秒</font> |
| `<font style="color:rgb(0, 0, 0);">isMute</font>` | `<font style="color:rgb(0, 0, 0);">Bool</font>` | <font style="color:rgb(0, 0, 0);">是否静音远端语音播放，默认</font><font style="color:rgb(0, 0, 0);"> </font>`<font style="color:rgb(0, 0, 0);">true</font>` |
| `<font style="color:rgb(0, 0, 0);">domain</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">固定服务域名，用于 SDK 网络请求</font> |
| `<font style="color:rgb(0, 0, 0);">dynamicDomain</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">动态域名，用于弹性请求切换</font> |
| `<font style="color:rgb(0, 0, 0);">conversationPrefix</font>` | `<font style="color:rgb(0, 0, 0);">String</font>` | <font style="color:rgb(0, 0, 0);">会话记录的标题前缀，用于数据库标识</font> |
| `<font style="color:rgb(0, 0, 0);">paths</font>` | `<font style="color:rgb(0, 0, 0);">[String: Any]?</font>` | <font style="color:rgb(0, 0, 0);">自定义请求路径字典，会替换默认路径配置（可选）</font> |
| `<font style="color:rgb(0, 0, 0);">params</font>` | `<font style="color:rgb(0, 0, 0);">[String: Any]?</font>` | <font style="color:rgb(0, 0, 0);">自定义请求参数字典，会替换默认参数配置（可选）</font> |


### 支持的翻译类型 (LOInterpretationType)
+ `.doubleTranslate`：双向翻译
+ `.singTranslate`：单向翻译
+ `.custom(...)`：自定义类型

---

## 快速开始
### 1. 初始化 Core
```swift
let core = LOInterpreterCore(config: config)
```

### 2. 监听翻译流和状态流
```swift
core.translationPublisher
    .sink { message in
        print("收到翻译消息: \(message.text)")
    }
    .store(in: &cancellables)

core.streamingStatePublisher
    .sink { state in
        print("状态变化: \(state)")
    }
    .store(in: &cancellables)
```

### 3. 启动翻译流程
```swift
core.start()
```

### 4. 停止翻译
```swift
core.stop()
```

---

## 静音控制
```swift
core.muteRemoteAudioStream(true)  // 静音
core.muteRemoteAudioStream(false) // 取消静音
```

---

## 支持的音频输入模式
| 模式 | 说明 |
| --- | --- |
| `.microphone` | 使用系统麦克风，SDK 管理录音流程 |
| `.ble` | 蓝牙输入，依赖 LOBleKit 子模块 |


---

## 事件流说明 (Combine)
| Publisher | 触发条件 |
| --- | --- |
| `translationPublisher` | 收到翻译消息时触发 |
| `streamingStatePublisher` | 状态变更时触发（启动/失败/退出等） |


---

## 状态流示例 (LORecordingState)
```swift
enum LORecordingState {
    case initial
    case joined
    case didLeaveChannel
    case stoppedByBLE(type: Int, sessionId: String, status: Int)
    case failure(LOInterpreterError)
    case streamMessageReceived(LOInterpreterReciveMessage)
}
```

---

## ❗ 错误码说明 (LOInterpreterError)
```swift
enum LOInterpreterError: Error {
    case authorize(error: LOAuthError)      // 权限相关错误
    case token(error: LOTokenError)         // 声网 token 错误
    case stream(error: LOStreamError)       // 流传输错误
    case joinChannelFailure(error: Int)     // 加入频道失败，返回 Agora 错误码
    case joinChannelTimeout                 // 加入频道超时
    case permissionDenied(type: String)     // 麦克风/蓝牙权限拒绝
    case unknown(Error)                     // 未知错误
}

enum LOUserOfflineReason: Int {
    case quit = 0               // 用户主动退出
    case dropped = 1            // 掉线
    case becomeAudience = 2     // 转为观众模式
    case unknow                 // 未知原因
}
```

---

## 注意事项
+ 若使用 BLE 输入，需引入 `LOBleKit` 模块。
+ 每次 `start()` 调用会自动生成唯一的频道 ID，并重置频道。
+ 如果配置为静音，则不会播放远端音频流。
+ 会自动管理会话 ID 以及缓存翻译内容。

---

## 📚 依赖组件
+ [Combine](https://developer.apple.com/documentation/combine)
+ [Agora RTC SDK](https://www.agora.io/)
+ SQLite（用于持久化翻译记录）

---

## 🧾 License
MIT License. © 2025 Wayne Chou

