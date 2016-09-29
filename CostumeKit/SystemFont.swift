//
//  SystemFont.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/17/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

public struct SystemFont : Font {
  public var weight: CGFloat = UIFontWeightRegular

  public init(size: FontSize = .textStyle(.body), weight: CGFloat = UIFontWeightRegular) {
    self.size = size
    self.weight = weight
  }

  // Font

  public var size: FontSize

  // FontConvertible

  public var FontValue: UIFont {
    return .systemFont(ofSize: pointSize, weight: weight)
  }
}
