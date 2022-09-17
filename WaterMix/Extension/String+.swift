//
//  String+.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/18.
//

import Foundation


extension String {
    
    func numberFormatter(number: Int) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(from: NSNumber(value: number))!
    }
}
