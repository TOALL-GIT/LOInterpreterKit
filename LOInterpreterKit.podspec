Pod::Spec.new do |s|
  s.name             = 'LOInterpreterKit'
  s.version          = '0.1.25'
  s.summary          = 'LOInterpreterKit components'
  s.description      = <<-DESC
  LOInterpreterKit is a real-time interpretation SDK for iOS, enabling two-way voice translation using BLE or built-in mic.
  DESC
  s.homepage         = 'http://192.168.16.23:8088/ios/lospecs/LOInterpreterKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wayne' => 'zhouzhiwei@lian-o.com' }
  s.source           = { :git => 'https://github.com/TOALL-GIT/LOInterpreterKit.git', :tag => s.version.to_s}
  s.ios.deployment_target = '15.1'
  s.swift_versions = "5.5"

  s.subspec 'Core' do |core|
    core.vendored_frameworks = 'LOInterpreterKit.framework'
  end

  s.subspec 'WithPod' do |withpod|
    withpod.vendored_frameworks = 'LOInterpreterPodKit.framework'
    withpod.dependency 'LOBleKit'
    withpod.dependency 'LOLibopus'
  end

  s.default_subspec = 'Core'

  s.dependency 'Moya', '~> 15.0'
  s.dependency 'AgoraAudio_iOS', '~> 4.5.2'
  s.dependency 'SQLite.swift'
end
