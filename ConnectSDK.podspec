Pod::Spec.new do |s|
  s.name             = 'ConnectSDK-My'
  s.version          = '1.0.0'
  s.summary          = 'A powerful SDK for device connectivity.'
  s.description      = 'ConnectSDK provides seamless device discovery and interaction capabilities.'
  s.homepage         = 'https://github.com/Roman-Fedotov-iOS/ConnectSDK-My'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :git => 'https://github.com/Roman-Fedotov-iOS/ConnectSDK-My', :tag => s.version.to_s }
  s.platform         = :ios, '12.0'
  s.swift_version    = '5.0'

  s.source_files     = 'core/**/*.{h,m,swift}'
  s.public_header_files = 'core/**/*.h'
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
end