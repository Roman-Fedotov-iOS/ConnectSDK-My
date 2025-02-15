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
  s.requires_arc = false
  s.subspec 'ConnectSDK-My' do |ss|
  ss.source_files = 'core/WebOSWebAppSession.m'
  ss.requires_arc = true
end

  s.source_files     = 'core/**/*.{h,m,swift}'
  s.public_header_files = 'core/**/*.h'

  s.xcconfig = {
      "OTHER_LDFLAGS" => "$(inherited) -ObjC",
      "HEADER_SEARCH_PATHS" => "$(PODS_TARGET_SRCROOT)/core"
  }

  s.frameworks       = 'Foundation', 'UIKit'

  # Prefix Header Definitions
  s.prefix_header_contents = <<-PREFIX
                                  //
                                  //  Prefix header for ConnectSDK
                                  //
                                  #define CONNECT_SDK_VERSION @"#{s.version}"

                                  // Uncomment this line to enable SDK logging
                                  //#define CONNECT_SDK_ENABLE_LOG

                                  #ifndef kConnectSDKWirelessSSIDChanged
                                  #define kConnectSDKWirelessSSIDChanged @"Connect_SDK_Wireless_SSID_Changed"
                                  #endif

                                  #ifdef CONNECT_SDK_ENABLE_LOG
                                      #ifdef DEBUG
                                      #   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
                                      #else
                                      #   define DLog(...)
                                      #endif
                                  #else
                                      #   define DLog(...)
                                  #endif
                               PREFIX
end