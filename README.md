# YHImageViewer

[![Version](https://img.shields.io/cocoapods/v/YHImageViewer.svg?style=flat)](http://cocoapods.org/pods/YHImageViewer)
[![License](https://img.shields.io/cocoapods/l/YHImageViewer.svg?style=flat)](http://cocoapods.org/pods/YHImageViewer)
[![Platform](https://img.shields.io/cocoapods/p/YHImageViewer.svg?style=flat)](http://cocoapods.org/pods/YHImageViewer)

YHImageViewer provides a simple way to show an image on fullscreen.

Minimum features are available. It is still under development.

Issues and PRs are welcome :)

## Screenshot

![Screenshot](https://raw.githubusercontent.com/wiki/hiragram/YHImageViewer/images/screenshot.gif)

## Installation

YHImageViewer is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "YHImageViewer"
```

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

In your ViewController class:

```swift
func imageTapped(recognizer:UITapGestureRecognizer) {
    let imageViewer = YHImageViewer()
    imageViewer.backgroundColor = UIColor.blackColor()
    self.imageViewer = imageViewer
    // ^- This line is required. 
    // If imageViewer is referenced by nothing, 
    // it will be released immediately and window will not appear.
    imageViewer.show(sampleImageView)
}
```

## Roadmaps

Some features under development can be seen in [issues](./issues) or [milestones](./milestones).

### v0.3 release

includes:

- [ ] Blurry background
- [ ] Custom view on background / foreground
- [ ] Manager class
- [ ] Drag animation with physics
- [ ] Some refactoring

## Author

Yuya Hirayama / [@hiragram](http://twitter.com/hiragram) / y@yura.me

Japanese and English are welcome.

## License

YHImageViewer is available under the MIT license. See the LICENSE file for more info.
