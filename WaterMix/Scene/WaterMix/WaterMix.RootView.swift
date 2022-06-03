//
//  WaterMix.RootView.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import Foundation
import UIKit
import SnapKit

extension WaterMix {
    
    final class RootView: BaseUIView {
        
        private let totalAccountView = TotalAccountView()
                
        override func setup() {
            
            [
                totalAccountView
            ].forEach { self.addSubview($0) }
            
        }
        
        override func setupConstraints() {
            totalAccountView.snp.makeConstraints { make in
                make.top.equalTo(self.safeAreaLayoutGuide).offset(18)
                make.leading.equalToSuperview().offset(15)
                make.width.equalTo(self).multipliedBy(0.92)
                make.height.equalTo(157)
            }
        }
        
    }
}
