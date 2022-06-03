//
//  TotalAccountView.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import UIKit
import SnapKit

final class TotalAccountView: BaseUIView {
    
    private let totalStockLabel = UILabel()
    private let totalStockValue = UILabel()
    
    private let lineView = UIView()
    
    private let proAndLossRatioLabel = UILabel()
    private let proAndLossRatioValue = UILabel()
    
    private let totalAccountLabel = UILabel()
    private let totalAccountValue = UILabel()
    
    private let totalPriceLabel = UILabel()
    private let totalPriceValue = UILabel()


    override func setup() {
        
        [
         totalStockLabel,
         totalStockValue,
         lineView,
         proAndLossRatioLabel,
         proAndLossRatioValue,
         totalAccountLabel,
         totalAccountValue,
         totalPriceLabel,
         totalPriceValue
        ].forEach { self.addSubview($0) }
    
    }
    
    override func setupConstraints() {
        
        
        totalStockLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(self).multipliedBy(0.29)
            make.height.equalTo(19)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(totalStockLabel.snp.bottom).offset(3)
            make.width.equalTo(self)
            make.height.equalTo(2)
        }
        
    }
    
    override func bind() {
        totalStockLabel.text = "최종 평단가"
    }
    

    
    
}
