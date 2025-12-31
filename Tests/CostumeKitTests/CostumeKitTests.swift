import XCTest
@testable import CostumeKit

// MARK: - Test Color Palette

enum TestColors: String, ColorPalette {
    case red = "FF0000"
    case green = "00FF00"
    case blue = "0000FF"
    case white = "FFFFFF"
    case black = "000000"
    case teal = "3CB39E"
}

// MARK: - Test Costume

class TestCostume: Costume {
    var name: String { "Test Costume" }
    var description: String { "A costume for testing" }
}

// MARK: - Color Tests

final class ColorTests: XCTestCase {
    func testHexStringParsing6Digit() {
        let color = PlatformColor(hexString: "FF0000")
        XCTAssertNotNil(color)

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }

    func testHexStringParsingWithHash() {
        let color = PlatformColor(hexString: "#00FF00")
        XCTAssertNotNil(color)

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 1.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }

    func testHexStringParsing3Digit() {
        let color = PlatformColor(hexString: "F00")
        XCTAssertNotNil(color)

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }

    func testHexIntParsing() {
        let color = PlatformColor(hex: 0x0000FF)
        XCTAssertNotNil(color)

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 0.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 1.0, accuracy: 0.01)
    }

    func testHexStringWithAlpha() {
        let color = PlatformColor(hexString: "FF0000", alpha: 0.5)
        XCTAssertNotNil(color)

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color?.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(alpha, 0.5, accuracy: 0.01)
    }

    func testInvalidHexString() {
        let color = PlatformColor(hexString: "GGGGGG")
        XCTAssertNil(color)
    }

    func testInvalidHexLength() {
        let color = PlatformColor(hexString: "FF00")
        XCTAssertNil(color)
    }

    func testHexStringOutput() {
        let color = PlatformColor(hexString: "3CB39E")
        XCTAssertNotNil(color)
        XCTAssertEqual(color?.hexString, "3CB39E")
    }
}

// MARK: - ColorPalette Tests

final class ColorPaletteTests: XCTestCase {
    func testColorPaletteRed() {
        let color = TestColors.red.colorValue

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 1.0, accuracy: 0.01)
        XCTAssertEqual(green, 0.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0.0, accuracy: 0.01)
    }

    func testColorPaletteTeal() {
        let color = TestColors.teal.colorValue

        var red: CGFloat = 0, green: CGFloat = 0, blue: CGFloat = 0, alpha: CGFloat = 0
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

        XCTAssertEqual(red, 0x3C / 255.0, accuracy: 0.01)
        XCTAssertEqual(green, 0xB3 / 255.0, accuracy: 0.01)
        XCTAssertEqual(blue, 0x9E / 255.0, accuracy: 0.01)
    }
}

// MARK: - ColorConvertible Tests

final class ColorConvertibleTests: XCTestCase {
    func testDarkened() {
        let original = TestColors.white.colorValue
        let darkened = TestColors.white.darkened(amount: 0.5)

        var originalBrightness: CGFloat = 0
        var darkenedBrightness: CGFloat = 0
        var hue: CGFloat = 0, saturation: CGFloat = 0, alpha: CGFloat = 0

        original.getHue(&hue, saturation: &saturation, brightness: &originalBrightness, alpha: &alpha)
        darkened.getHue(&hue, saturation: &saturation, brightness: &darkenedBrightness, alpha: &alpha)

        XCTAssertLessThan(darkenedBrightness, originalBrightness)
    }

    func testLightened() {
        let original = TestColors.black.colorValue
        let lightened = TestColors.black.lightened(amount: 0.5)

        var originalBrightness: CGFloat = 0
        var lightenedBrightness: CGFloat = 0
        var hue: CGFloat = 0, saturation: CGFloat = 0, alpha: CGFloat = 0

        original.getHue(&hue, saturation: &saturation, brightness: &originalBrightness, alpha: &alpha)
        lightened.getHue(&hue, saturation: &saturation, brightness: &lightenedBrightness, alpha: &alpha)

        XCTAssertGreaterThan(lightenedBrightness, originalBrightness)
    }
}

// MARK: - Costume Tests

final class CostumeTests: XCTestCase {
    func testCostumeName() {
        let costume = TestCostume()
        XCTAssertEqual(costume.name, "Test Costume")
    }

    func testCostumeDescription() {
        let costume = TestCostume()
        XCTAssertEqual(costume.description, "A costume for testing")
    }
}

// MARK: - SVG Tests

final class SVGTests: XCTestCase {
    enum TestSVGs: SVG {
        case icon
        case logo

        func metadata() -> SVGMetadata {
            switch self {
            case .icon:
                return SVGMetadata(name: "icon", size: CGSize(width: 24, height: 24), fullColor: false)
            case .logo:
                return SVGMetadata(name: "logo", size: CGSize(width: 200, height: 50), fullColor: true)
            }
        }
    }

    func testSVGMetadataIcon() {
        let metadata = TestSVGs.icon.metadata()
        XCTAssertEqual(metadata.name, "icon")
        XCTAssertEqual(metadata.size.width, 24)
        XCTAssertEqual(metadata.size.height, 24)
        XCTAssertFalse(metadata.fullColor)
    }

    func testSVGMetadataLogo() {
        let metadata = TestSVGs.logo.metadata()
        XCTAssertEqual(metadata.name, "logo")
        XCTAssertEqual(metadata.size.width, 200)
        XCTAssertEqual(metadata.size.height, 50)
        XCTAssertTrue(metadata.fullColor)
    }

    func testSVGMetadataEquality() {
        let meta1 = SVGMetadata(name: "test", size: CGSize(width: 10, height: 10), fullColor: true)
        let meta2 = SVGMetadata(name: "test", size: CGSize(width: 10, height: 10), fullColor: true)
        XCTAssertEqual(meta1, meta2)
    }
}

// MARK: - Font Tests

#if canImport(UIKit)
import UIKit

final class FontTests: XCTestCase {
    func testSystemFontCreation() {
        let font = SystemFont(size: .fixed(14), weight: .regular)
        XCTAssertNotNil(font.fontValue)
    }

    func testSystemFontPointSize() {
        let font = SystemFont(size: .fixed(14), weight: .regular)
        // Point size may be modified by accessibility settings, but should be at least 14
        XCTAssertGreaterThanOrEqual(font.pointSize, 14)
    }

    func testSystemFontWeight() {
        let font = SystemFont(size: .fixed(14), weight: .bold)
        XCTAssertEqual(font.weight, .bold)
    }

    func testFontSizeEquality() {
        let size1 = FontSize.fixed(14)
        let size2 = FontSize.fixed(14)
        XCTAssertEqual(size1, size2)

        let size3 = FontSize.textStyle(.body)
        let size4 = FontSize.textStyle(.body)
        XCTAssertEqual(size3, size4)
    }
}
#endif
