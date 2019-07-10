# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/)
and this project adheres to [Semantic Versioning](http://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- when the level is undefined or out of bounds, show question mark on battery (configurable via `noLevelText`).

## [1.3.5] - 2019-06-21

### Changed
- Swift 5, CocoaPods 1.7.

## [1.3.4] - 2019-06-01

### Added
- add `currentFillColor`.

## [1.3.3] - 2019-05-29

### Fixed
- fix compile error in Xcode 10.2

## [1.3.2]

### Added
- add `gradientThreshold` to allow gradually changing from `highLevelColor` to `lowLevelColor`.

## [1.3.1]

### Added
- support UIAppearance.

## [1.3.0]

### Changed
- Swift 4.2

### Fixed
- make the battery full at level 100%. (Thanks lampmanyao)

## [1.2.2] - 2018-07-06

### Fixed
- ensure the corners of the fill aren't sticking out when the border width is 1. (Thanks rondavis007)

## [1.2.1] - 2018-05-20

### Changed
- use SwiftLint and SwiftFormat

## [1.2] - 2017-11-10

### Added
- added borderColor.

## [1.1] - 2017-07-15

### Changed
- Swift 4
