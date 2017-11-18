# CostumeKit :tophat:

> Base types for theming an app.

**CostumeKit** is made of up a set of Swift protocols. They are meant to be implemented by you in your app.

Featured in [_Little Bites of Cocoa Bite #270: Implementing Theming with CostumeKit_](https://www.littlebitesofcocoa.com/270-implementing-theming-with-costumekit)

## Color :art:

Includes `Color` and `ColorPalette` protocols.

Usage:

``` swift
public enum MyAppColors : Color, ColorPalette {
  case white = "FFFFFF"
  case lightTeal = "3CB39E"
  case forestGreen = "216055"
  case black = "000000"
}
```

## Font :capital_abcd:

Includes `Font` protocol, and one concrete `SystemFont` implementation for **iOS** system fonts.

Usage:

``` swift
public struct MyAppFont : Font {
  public init(size: FontSize = .textStyle(.body)) {
    self.size = size
  }

  // Font

  public var size: FontSize

  // FontConvertible

  public var FontValue: UIFont {
    return UIFont(name: "SomeCustomFont", size: pointSize)!
  }
}
```

## SVG :stars:

Includes `SVG` Protocol and `SVGMetadata` type.

Usage:

``` swift
enum MyAppSVGs {
  case clockGlyph
  case bird
}

extension MyAppSVGs : SVG {
  public func metadata() -> SVGMetadata {
    switch self {
      case .clockGlyph: return SVGMetadata(name: "clock", size: CGSize(width: 100, height: 100), fullColor: false)
      case .bird: return SVGMetadata(name: "bird", size: CGSize(width: 58, height: 28), fullColor: true)
    }
  }
}
```

What you do with `SVGMetadata` is up to you. I recommend [SwiftSVG](https://github.com/mchoe/SwiftSVG) from [Michael Choe](https://github.com/mchoe). [Read  more here to learn how to use it](https://www.littlebitesofcocoa.com/198-parsing-rendering-svgs-with-swiftsvg).

**CostumeKit**'s goals are to be a generic solution, so no assumptions are made about how something should be retrieved from disk, parsed, etc. You'll need to implement these anyways, so nothing is forced on you.

## Costume :tophat:

Includes `Costume` protocol. Usage:

``` swift
open class MyAppCostume : Costume {
  let spacing = CGFloat(8)

  public func wearRootBackground(_ view: UIView) {
    view.backgroundColor = Color.black.colorValue
  }

  public func wearHeadline(_ label: UILabel) {
    label.font = MyAppFont(size: .textStyle(.title1)).fontValue
    label.textColor = MyAppColors.forestGreen.colorValue
  }

  public var name: String { return "Default" }
  public var description: String { return "The default costume." }

  public init() { }
}
```

Cheers.
