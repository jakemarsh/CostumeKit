# CostumeKit 🎩

> Base types for theming an app.

**CostumeKit** provides a set of Swift protocols for building app themes (costumes). It supports both **UIKit** and **SwiftUI**, with full platform coverage for iOS, macOS, tvOS, and watchOS.

Featured in [_Little Bites of Cocoa Bite #270: Implementing Theming with CostumeKit_](https://littlebitesofcocoa.com/270-implementing-theming-with-costumekit)

## Installation

### Swift Package Manager

Add CostumeKit to your project via Xcode:

1. File → Add Packages...
2. Enter: `https://github.com/jakemarsh/CostumeKit`
3. Select the version you want

Or add it to your `Package.swift`:

```swift
dependencies: [
    .package(url: "https://github.com/jakemarsh/CostumeKit", from: "2.0.0")
]
```

## Quick Start

### 1. Define Your Colors

```swift
import CostumeKit

public enum AppColors: String, ColorPalette {
    case background = "FFFFFF"
    case primary = "3CB39E"
    case secondary = "216055"
    case text = "000000"
}
```

### 2. Create a Costume

```swift
public class AppCostume: Costume {
    public var name: String { "Default" }
    public var description: String { "The default app theme" }

    // Define your styling methods
    public func styleHeadline(_ label: UILabel) {
        label.font = SystemFont(size: .textStyle(.title1), weight: .bold).fontValue
        label.textColor = AppColors.primary.colorValue
    }

    public func styleBody(_ label: UILabel) {
        label.font = SystemFont(size: .textStyle(.body)).fontValue
        label.textColor = AppColors.text.colorValue
    }

    public init() {}
}
```

### 3. Apply Your Costume

**UIKit:**
```swift
let costume = AppCostume()
costume.styleHeadline(titleLabel)
costume.styleBody(descriptionLabel)
```

**SwiftUI:**
```swift
struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello")
                .foregroundColor(AppColors.primary.swiftUIColor)
            Text("World")
                .foregroundColor(AppColors.secondary.swiftUIColor)
        }
        .costume(AppCostume())
    }
}
```

## API Reference

### Color 🎨

`Color` is a String typealias that supports hex color values.

```swift
// Direct hex string usage
let color: Color = "FF0000"
let uiColor = color.colorValue  // UIColor or NSColor

// Or use UIColor/NSColor directly
let red = UIColor(hexString: "FF0000")
let green = UIColor(hexString: "#00FF00")  // # is optional
let blue = UIColor(hex: 0x0000FF)
let semiTransparent = UIColor(hexString: "FF0000", alpha: 0.5)
```

### ColorPalette

Define type-safe color palettes using enums:

```swift
public enum AppColors: String, ColorPalette {
    case white = "FFFFFF"
    case lightTeal = "3CB39E"
    case forestGreen = "216055"
    case black = "000000"
}

// Usage
let color = AppColors.forestGreen.colorValue  // UIColor/NSColor
let swiftUIColor = AppColors.forestGreen.swiftUIColor  // SwiftUI Color
```

### ColorConvertible

Any type conforming to `ColorConvertible` can be converted to platform colors:

```swift
let darkened = AppColors.primary.darkened(amount: 0.3)
let lightened = AppColors.primary.lightened(amount: 0.3)
```

### Font 📝

The `Font` protocol supports dynamic type with custom fonts:

```swift
public struct AppFont: Font {
    public var size: FontSize

    public init(size: FontSize = .textStyle(.body)) {
        self.size = size
    }

    public var fontValue: UIFont {
        UIFont(name: "CustomFont-Regular", size: pointSize)!
    }
}
```

### FontSize

Supports both dynamic text styles and fixed sizes with accessibility scaling:

```swift
// Dynamic (responds to user's text size preference)
let bodySize = FontSize.textStyle(.body)
let titleSize = FontSize.textStyle(.title1)

// Fixed (still adjusts for accessibility)
let fixedSize = FontSize.fixed(14)
```

### SystemFont

A built-in implementation for system fonts:

```swift
let regular = SystemFont(size: .textStyle(.body))
let bold = SystemFont(size: .textStyle(.headline), weight: .bold)
let fixed = SystemFont(size: .fixed(18), weight: .medium)

// UIKit
label.font = bold.fontValue

// SwiftUI
Text("Hello").font(bold.swiftUIFont)
```

### SVG 🌟

Define SVG asset metadata:

```swift
enum AppSVGs: SVG {
    case clockGlyph
    case bird

    func metadata() -> SVGMetadata {
        switch self {
        case .clockGlyph:
            return SVGMetadata(name: "clock", size: CGSize(width: 100, height: 100), fullColor: false)
        case .bird:
            return SVGMetadata(name: "bird", size: CGSize(width: 58, height: 28), fullColor: true)
        }
    }
}
```

What you do with `SVGMetadata` is up to you. We recommend [SwiftSVG](https://github.com/mchoe/SwiftSVG) for parsing and rendering.

### Costume 🎩

The main protocol for defining themes:

```swift
public class DarkCostume: Costume {
    public var name: String { "Dark" }
    public var description: String { "Dark mode theme" }

    public let backgroundColor = AppColors.black
    public let primaryColor = AppColors.lightTeal
    public let textColor = AppColors.white

    public func styleBackground(_ view: UIView) {
        view.backgroundColor = backgroundColor.colorValue
    }

    public func styleTitle(_ label: UILabel) {
        label.font = SystemFont(size: .textStyle(.title1), weight: .bold).fontValue
        label.textColor = primaryColor.colorValue
    }

    public init() {}
}
```

## SwiftUI Integration

### Environment Access

CostumeKit integrates with SwiftUI's environment system:

```swift
// Set costume at root
@main
struct MyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .costume(AppCostume())
        }
    }
}

// Access in child views
struct ThemedView: View {
    @Environment(\.costume) var costume

    var body: some View {
        if let appCostume = costume?.as(AppCostume.self) {
            Text(appCostume.name)
        }
    }
}
```

### Color Extensions

```swift
// From ColorPalette
Text("Hello")
    .foregroundColor(AppColors.primary.swiftUIColor)

// From hex string
Text("World")
    .foregroundColor(Color(hex: "3CB39E"))
```

### Font Extensions

```swift
let font = SystemFont(size: .textStyle(.title1), weight: .bold)

Text("Hello")
    .font(font.swiftUIFont)
```

## Platform Support

| Platform | Minimum Version |
|----------|-----------------|
| iOS      | 15.0            |
| macOS    | 12.0            |
| tvOS     | 15.0            |
| watchOS  | 8.0             |

## Migration from 1.x

CostumeKit 2.0 modernizes the API while keeping the same concepts:

| 1.x | 2.0 |
|-----|-----|
| `UIFontWeightRegular` | `UIFont.Weight.regular` |
| `UIFontTextStyle.body` | `UIFont.TextStyle.body` |
| `hex.characters.count` | `hex.count` |
| UIKit only | UIKit + SwiftUI |

All protocols (`Costume`, `ColorPalette`, `Font`, `SVG`) remain unchanged.

## License

MIT License. See [LICENSE](LICENSE) for details.

## Author

Jake Marsh ([@jakemarsh](https://twitter.com/jakemarsh))
