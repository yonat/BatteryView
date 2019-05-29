
Pod::Spec.new do |s|

  s.name         = "BatteryView"
  s.version      = "1.3.2"
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
  s.social_media_url   = "http://twitter.com/yonatsharon"

  s.swift_version = '4.2'
  s.platform     = :ios, "8.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/yonat/BatteryView.git", :tag => s.version }
  s.source_files  = "Sources/*"
end
