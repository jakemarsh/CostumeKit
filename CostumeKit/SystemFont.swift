//
//  SystemFont.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/17/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

public struct SystemFont : Font {
  public var weight: CGFloat = UIFont.Weight.regular.rawValue

  public init(size: FontSize = .textStyle(.body), weight: CGFloat = UIFont.Weight.regular.rawValue) {
    self.size = size
    self.weight = weight
  }

  // Font

  public var size: FontSize

  // FontConvertible

  public var fontValue: UIFont {
    return .systemFont(ofSize: pointSize, weight: UIFont.Weight(rawValue: weight))
  }
}
