//
//  UIFont+.swift
//  ios-menu-app
//
//  Created by Sunny on 2023/05/20.
//

import UIKit

extension UIFont {
    
    enum FontSize: CGFloat {
        case _0 = 0
        case _10 = 10
        case _11 = 11
        case _13 = 13
        case _15 = 15
        case _16 = 16
        case _17 = 17
        case _19 = 19
        case _20 = 20
        case _22 = 22
        case _25 = 25
        case _28 = 28
        case _30 = 30
    }
    
    static func pretendard(size fontSize: FontSize, weight: UIFont.Weight) -> UIFont {
          let familyName = "Pretendard"

          var weightString: String
          switch weight {
          case .black:
              weightString = "Black"
          case .bold:
              weightString = "Blod"
          case .heavy:
              weightString = "ExtraBold"
          case .ultraLight:
              weightString = "ExtraLight"
          case .light:
              weightString = "Light"
          case .medium:
              weightString = "Medium"
          case .regular:
              weightString = "Regular"
          case .semibold:
              weightString = "SemiBold"
          case .thin:
              weightString = "Thin"
          default:
              weightString = "Regular"
          }

        return UIFont(name: "\(familyName)-\(weightString)", size: fontSize.rawValue) ?? .systemFont(ofSize: fontSize.rawValue, weight: weight)
      }
}
