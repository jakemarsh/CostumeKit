//
//  Font.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
import CoreGraphics

#if os(iOS) || os(tvOS) || os(watchOS)
  import UIKit
#endif

public protocol Font : FontConvertible {
  var size: FontSize { get set }
}

public enum FontSize {
  #if os(iOS) || os(tvOS) || os(watchOS)
  case textStyle(_: UIFontTextStyle)
  #endif

  case fixed(_: CGFloat)
}

extension Font {
  public var pointSize: CGFloat {
    var pointSize: CGFloat!

    #if os(iOS) || os(tvOS) || os(watchOS)
    switch size {
    case .textStyle(let style): pointSize = FontType.preferredFont(forTextStyle: style).pointSize
    default: break
    }
    #endif

    switch size {
    case .fixed(let ps): pointSize = ps + CGFloat(fixedSizeModifier)
    default: break
    }

    return pointSize
  }

  var fixedSizeModifier: Int {
    #if os(iOS) || os(tvOS)
    let contentSize = UIApplication.shared.preferredContentSizeCategory

    switch contentSize {
    case UIContentSizeCategory.accessibilityExtraExtraExtraLarge: return 9
    case UIContentSizeCategory.accessibilityExtraExtraLarge: return 8
    case UIContentSizeCategory.accessibilityExtraLarge: return 7
    case UIContentSizeCategory.accessibilityLarge: return 6
    case UIContentSizeCategory.accessibilityMedium: return 5
    case UIContentSizeCategory.extraExtraExtraLarge: return 4
    case UIContentSizeCategory.extraExtraLarge: return 3
    case UIContentSizeCategory.extraLarge: return 2
    case UIContentSizeCategory.large: return 1
    case UIContentSizeCategory.medium: return 0
    case UIContentSizeCategory.small: return -1
    case UIContentSizeCategory.extraSmall: return -2
    default: return 0
    }
    #elseif os(macOS)
    return 0
    #elseif os(watchOS)
    return 0
    #endif
  }
}
