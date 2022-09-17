//
//  Float+.swift
//  WaterMix
//
//  Created by tony on 2022/09/17.
//

import Foundation

extension Float {
    func withCommas() -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter.string(from: NSNumber(value:self))!
    }
}
