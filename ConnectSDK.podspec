Pod::Spec.new do |s|
  s.name             = 'ConnectSDK-My'
  s.version          = '1.0.0'
  s.summary          = 'A powerful SDK for device connectivity.'
  s.description      = 'ConnectSDK provides seamless device discovery and interaction capabilities.'
  s.homepage         = 'https://github.com/Roman-Fedotov-iOS/ConnectSDK-My'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Your Name' => 'your.email@example.com' }
  s.source           = { :git => 'https://github.com/Roman-Fedotov-iOS/ConnectSDK-My', :tag => s.version.to_s }
  s.xcconfig = {
      "OTHER_LDFLAGS" => "$(inherited) -ObjC"
  }
  s.platform         = :ios, '12.0'
  s.swift_version    = '5.0'

  s.source_files     = 'core/**/*.{h,m,swift}'
  s.public_header_files = 'core/**/*.h'
  s.frameworks       = 'Foundation', 'UIKit'
  s.requires_arc     = true
  s.prefix_header_contents = <<-PREFIX
                                  //
                                  //  Prefix header
                                  //
                                  //  The contents of this file are implicitly included at the beginning of every source file.
                                  //
                                  //  Copyright (c) 2015 LG Electronics.
                                  //
                                  //  Licensed under the Apache License, Version 2.0 (the "License");
                                  //  you may not use this file except in compliance with the License.
                                  //  You may obtain a copy of the License at
                                  //
                                  //      http://www.apache.org/licenses/LICENSE-2.0
                                  //
                                  //  Unless required by applicable law or agreed to in writing, software
                                  //  distributed under the License is distributed on an "AS IS" BASIS,
                                  //  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
                                  //  See the License for the specific language governing permissions and
                                  //  limitations under the License.
                                  //

                                  #define CONNECT_SDK_VERSION @"#{s.version}"

                                  // Uncomment this line to enable SDK logging
                                  //#define CONNECT_SDK_ENABLE_LOG

                                  #ifndef kConnectSDKWirelessSSIDChanged
                                  #define kConnectSDKWirelessSSIDChanged @"Connect_SDK_Wireless_SSID_Changed"
                                  #endif

                                  #ifdef CONNECT_SDK_ENABLE_LOG
                                      // credit: http://stackoverflow.com/a/969291/2715
                                      #ifdef DEBUG
                                      #   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
                                      #else
                                      #   define DLog(...)
                                      #endif
                                  #else
                                      #   define DLog(...)
                                  #endif
                               PREFIX

  non_arc_files =
    "core/Frameworks/asi-http-request/External/Reachability/*.{h,m}",
    "core/Frameworks/asi-http-request/Classes/*.{h,m}"

  s.subspec 'Core' do |sp|
    sp.source_files  = "ConnectSDKDefaultPlatforms.h", "core/**/*.{h,m}"
    sp.exclude_files = (non_arc_files.dup << "core/ConnectSDK*Tests/**/*" << "core/Frameworks/LGCast/**/*.h")
    sp.private_header_files = "core/**/*_Private.h"
    sp.requires_arc = true

    sp.dependency 'ConnectSDK/no-arc'
    sp.ios.vendored_frameworks = 'core/Frameworks/LGCast/LGCast.xcframework', 'core/Frameworks/LGCast/GStreamerForLGCast.xcframework'
    sp.preserve_paths =  'core/Frameworks/LGCast/LGCast.xcframework', 'core/Frameworks/LGCast/GStreamerForLGCast.xcframework'
  end

  s.subspec 'no-arc' do |sp|
    sp.source_files = non_arc_files
    sp.requires_arc = false
    # disable all warnings from asi-http-request
    sp.compiler_flags = '-w'
  end

  s.subspec 'GoogleCast' do |sp|
    cast_dir = "modules/google-cast"

    sp.dependency 'ConnectSDK/Core'
    sp.source_files = "#{cast_dir}/**/*.{h,m}"
    sp.exclude_files = "#{cast_dir}/*Tests/**/*"
    sp.private_header_files = "#{cast_dir}/**/*_Private.h"

    cast_version = "2.7.1"
    sp.dependency "google-cast-sdk", cast_version
    sp.framework = "GoogleCast"
    sp.xcconfig = {
        "FRAMEWORK_SEARCH_PATHS" => "$(PODS_ROOT)/google-cast-sdk/GoogleCastSDK-#{cast_version}-Release",
    }
  end
end