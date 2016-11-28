# StepProgressView
Simple battery shaped UIView.

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

**Fill Colors:**


```swift
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

## Installation

### CocoaPods:

```ruby
pod 'BatteryView'
```

### Manually:

Copy `Sources/*` to your Xcode project.
