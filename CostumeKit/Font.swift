//
//  Font.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/7/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

public protocol Font : FontConvertible {
  var size: FontSize { get set }
}

public enum FontSize {
  case textStyle(_: UIFontTextStyle)
  case fixed(_: CGFloat)
}

extension Font {
  public var pointSize: CGFloat {
    var pointSize: CGFloat
    
    switch size {
    case .textStyle(let style): pointSize = UIFont.preferredFont(forTextStyle: style).pointSize
    case .fixed(let ps): pointSize = ps + CGFloat(fixedSizeModifier)
    }
    
    return pointSize
  }

  var fixedSizeModifier: Int {
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
  }
}
