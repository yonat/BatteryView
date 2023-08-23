
Pod::Spec.new do |s|

  s.name         = "BatteryView"
  s.version      = "1.4.1"
  s.summary      = "Simple battery shaped UIView."

  s.description  = <<-DESC
Usage:

```swift
let batteryView   = BatteryView(frame: smallRect)
batteryView.level = 42 // anywhere in 0...100
```
                   DESC

  s.homepage     = "https://github.com/yonat/BatteryView"
  s.screenshots  = "https://raw.githubusercontent.com/yonat/BatteryView/master/Screenshots/Battery.png"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }

  s.author             = { "Yonat Sharon" => "yonat@ootips.org" }

  s.swift_version = '4.2'
  s.swift_versions = ['4.2', '5.0']
  s.platform     = :ios, "11.0"
  s.requires_arc = true
  s.weak_framework = 'SwiftUI'

  s.source       = { :git => "https://github.com/yonat/BatteryView.git", :tag => s.version }
  s.source_files  = "Sources/*"
  s.resources = ['PrivacyInfo.xcprivacy']

  s.pod_target_xcconfig = { 'LD_RUNPATH_SEARCH_PATHS' => '$(FRAMEWORK_SEARCH_PATHS)' } # fix Interface Builder render error

end
