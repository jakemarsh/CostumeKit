//
//  FontConvertible.swift
//  CostumeKit
//
//  Created by Jake Marsh on 9/28/16.
//  Copyright © 2016 Jake Marsh. All rights reserved.
//

import Foundation

#if os(iOS)
  public typealias FontType = UIFont
#elseif os(macOS)
  public typealias FontType = NSFont
#endif

public protocol FontConvertible {
  var fontValue: UIFont { get }
}

extension FontType : FontConvertible {
  public var fontValue: FontType { return self }
}
