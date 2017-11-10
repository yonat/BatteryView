# BatteryView
Simple battery shaped UIView.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url]
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/BatteryView.svg)](https://img.shields.io/cocoapods/v/BatteryView.svg)  
[![Platform](https://img.shields.io/cocoapods/p/BatteryView.svg?style=flat)](http://cocoapods.org/pods/BatteryView)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg?style=flat-square)](http://makeapullrequest.com)

<p align="center">
<img src="Screenshots/Battery.png">
</p>

## Usage

```swift
let batteryView = BatteryView(frame: smallRect)
batteryView.level = 42 // anywhere in 0...100
batteryView.lowThreshold = 25 // battery fill becomes red if level is below this threshold
```

## Changing Appearance

**Colors:**


```swift
batteryView.borderColor    = .darkGray
batteryView.highLevelColor = .green
batteryView.lowLevelColor  = .red
batteryView.noLevelColor   = .gray
```

**Battery Shape:**

```swift
batteryView.direction = .minXEdge     // terminal facing left

batteryView.terminalLengthRatio = 0.1 // relative to battery length
batteryView.terminalWidthRatio = 0.4  // relative to battery width

batteryView.borderWidth = 2.5         // default is batteryLength / 20
batteryView.cornerRadius = 5          // default is batteryLength / 10

```

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

### CocoaPods:

```ruby
pod 'BatteryView'
```

### Manually:

Copy `Sources/*` to your Xcode project.

## Meta

[@yonatsharon](https://twitter.com/yonatsharon)

[https://github.com/yonat/BatteryView](https://github.com/yonat/BatteryView)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE.txt
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com
