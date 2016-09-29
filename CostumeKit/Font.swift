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
    case .textStyle(let style): pointSize = UIFont.preferredFontForTextStyle((style) as String).pointSize
    case .fixed(let ps): pointSize = ps + CGFloat(fixedSizeModifier)
    }

    return pointSize
  }

  var fixedSizeModifier: Int {
    let contentSize = UIApplication.sharedApplication().preferredContentSizeCategory

    switch contentSize {
    case UIContentSizeCategoryAccessibilityExtraExtraLarge: return 8
    case UIContentSizeCategoryAccessibilityExtraLarge: return 7
    case UIContentSizeCategoryAccessibilityLarge: return 6
    case UIContentSizeCategoryAccessibilityMedium: return 5
    case UIContentSizeCategoryExtraExtraExtraLarge: return 4
    case UIContentSizeCategoryExtraExtraLarge: return 3
    case UIContentSizeCategoryExtraLarge: return 2
    case UIContentSizeCategoryLarge: return 1
    case UIContentSizeCategoryMedium: return 0
    case UIContentSizeCategorySmall: return -1
    case UIContentSizeCategoryExtraSmall: return -2
    default: return 0
    }
  }
}
