//
//  BaseUIView.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import UIKit
import SnapKit

class BaseUIView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
        bind()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
    }
    
    func setupConstraints() {
        
    }
    
    func bind() {
        
    }
    
}
