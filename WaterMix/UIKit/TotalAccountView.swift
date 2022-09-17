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
    let totalStockValue: UILabel = {
       let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 32)
        return label
    }()
    
    private let lineView : UIView = {
       let view = UIView()
       view.backgroundColor = UIColor._181818
       return view
    }()
    
    private let totalPriceLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .right
         label.textColor = UIColor.b8Bbbe
         label.font = UIFont.boldSystemFont(ofSize: 13)
         return label
    }()
    
    let totalPriceValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let totalAmountLabel: UILabel = {
        let label = UILabel()
         label.textAlignment = .right
         label.textColor = UIColor.b8Bbbe
         label.font = UIFont.boldSystemFont(ofSize: 13)
         return label
    }()
    
    let totalAmountValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let proAndLossRatioLabel:UILabel = {
        let label = UILabel()
         label.textAlignment = .right
         label.textColor = UIColor.b8Bbbe
         label.font = UIFont.boldSystemFont(ofSize: 13)
         return label
    }()
    
    let proAndLossRatioValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    private let proAndLossLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.b8Bbbe
        label.font = UIFont.boldSystemFont(ofSize: 13)
        return label
    }()
    

    let proAndLossValue: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    override func setup() {
        
        [
         totalStockLabel,
         totalStockValue,
         lineView,
         proAndLossRatioLabel,
         proAndLossRatioValue,
         totalAmountLabel,
         totalAmountValue,
         totalPriceLabel,
         totalPriceValue,
         proAndLossLabel,
         proAndLossValue
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
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(self)
            make.height.equalTo(2)
        }
        
        totalStockValue.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(6)
            make.trailing.equalTo(self.snp.trailing)
            make.width.equalTo(self).multipliedBy(0.6)
            make.height.equalTo(32)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(totalStockValue.snp.bottom).offset(15)
            make.trailing.equalTo(totalPriceValue.snp.leading).inset(-10)
            make.width.greaterThanOrEqualTo(67)
            make.centerY.equalTo(totalPriceValue.snp.centerY)
        }
        
        totalPriceValue.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(25)
        }
        
        totalPriceValue.setContentHuggingPriority(.defaultLow, for: .horizontal)
     
        totalAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(16)
            make.trailing.equalTo(totalAmountValue.snp.leading).inset(-4)
            make.width.greaterThanOrEqualTo(44)
            make.bottom.equalTo(totalAmountValue.snp.bottom)

        }
        
        totalAmountValue.snp.makeConstraints { make in
            make.top.equalTo(totalAmountLabel.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(25)
        }
        
        totalAmountValue.setContentHuggingPriority(.defaultLow, for: .horizontal)
     
        
        proAndLossRatioLabel.snp.makeConstraints { make in
            make.top.equalTo(totalAmountLabel.snp.bottom).offset(15)
            make.trailing.equalTo(proAndLossRatioValue.snp.leading).inset(-4)
            make.width.greaterThanOrEqualTo(31)
            make.bottom.equalTo(proAndLossRatioValue.snp.bottom)
        }
        
        proAndLossRatioValue.snp.makeConstraints { make in
            make.top.equalTo(proAndLossRatioLabel.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(25)
        }
        
        proAndLossRatioValue.setContentHuggingPriority(.defaultLow, for: .horizontal)
     
        proAndLossLabel.snp.makeConstraints { make in
            make.top.equalTo(proAndLossRatioLabel.snp.bottom).offset(15)
            make.trailing.equalTo(proAndLossValue.snp.leading).inset(-4)
            make.width.greaterThanOrEqualTo(31)
            make.bottom.equalTo(proAndLossValue.snp.bottom)
        }
        
        proAndLossValue.snp.makeConstraints { make in
            make.top.equalTo(proAndLossLabel.snp.top)
            make.trailing.equalTo(self.snp.trailing)
            make.height.equalTo(25)
        }
    
        
    }
    
    override func bind() {
        totalStockLabel.text = L10n.totalPurchasePrice.description
        proAndLossRatioLabel.text = L10n.ratio.description
        totalAmountLabel.text = L10n.totalAmount.description
        totalPriceLabel.text = L10n.totalPrice.description
        proAndLossLabel.text = L10n.proAndLoss.description
        
        totalStockValue.text = "0"
        proAndLossRatioValue.text = "0"
        totalAmountValue.text = "0"
        totalPriceValue.text = "0"
        proAndLossValue.text = "0"

    }
    

    
    
}
