//
//  SystemFont.swift
//  CostumeKit
//
//  Created by Jake Marsh on 8/17/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation
import CoreGraphics

public struct SystemFont : Font {
  public var weight: CGFloat = FontType.Weight.regular.rawValue

  #if os(iOS) || os(tvOS)
  public init(size: FontSize = .textStyle(.body), weight: CGFloat = FontType.Weight.regular.rawValue) {
    self.size = size
    self.weight = weight
  }
  #elseif os(macOS)
  public init(size: FontSize = .fixed(12), weight: CGFloat = FontType.Weight.regular.rawValue) {
    self.size = size
    self.weight = weight
  }
  #endif

  // Font

  public var size: FontSize

  // FontConvertible

  public var fontValue: FontType {
    return .systemFont(ofSize: pointSize, weight: FontType.Weight(rawValue: weight))
  }
}
