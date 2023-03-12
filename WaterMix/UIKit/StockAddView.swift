//
//  StockAddView.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import UIKit
import SnapKit
import TextFieldEffects

final class StockAddView: BaseUIView {
    
    private let titleLabel = UILabel()
    private let lineView : UIView = {
       let view = UIView()
       view.backgroundColor = UIColor._181818
       return view
    }()

    let stockPriceTextField: AkiraTextField = {
      let textField = AkiraTextField()
        textField.backgroundColor = UIColor.f8F8F8
        textField.borderColor = UIColor.f8F8F8
        textField.textColor = UIColor.black
        textField.placeholderColor = UIColor._929292
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [
            NSAttributedString.Key.foregroundColor : UIColor._929292,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
        ])
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    
    let stockAmountTextField: AkiraTextField = {
        let textField = AkiraTextField()
        textField.backgroundColor = UIColor.f8F8F8
        textField.borderColor = UIColor.f8F8F8
        textField.textColor = UIColor.black
        textField.placeholderColor = UIColor._929292
        textField.font = UIFont.systemFont(ofSize: 16)
        textField.attributedPlaceholder = NSAttributedString(string: "", attributes: [
              NSAttributedString.Key.foregroundColor : UIColor._929292,
              NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
          ])
        textField.keyboardType = .decimalPad
        return textField
    }()
    
    private let totalPriceLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor._555555
        label.font = UIFont.systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()
    
    public let totalPriceValue: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .right
        return label
    }()
    
    init(title: String, stockPriceText: String, sotckAmountText: String, totalPriceText: String) {
        self.titleLabel.text = title
        self.stockPriceTextField.placeholder = stockPriceText
        self.stockAmountTextField.placeholder = sotckAmountText
        self.totalPriceLabel.text = totalPriceText
        super.init(frame: .zero)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setup() {
        
        [
         titleLabel,
         lineView,
         stockPriceTextField,
         stockAmountTextField,
         totalPriceLabel,
         totalPriceValue
        ].forEach { self.addSubview($0) }
        
    }

    override func setupConstraints() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview()
            make.width.equalTo(self).multipliedBy(0.29)
            make.height.equalTo(19)
        }
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
            make.leading.trailing.equalToSuperview()
            make.width.equalTo(self)
            make.height.equalTo(2)
        }
        
        stockPriceTextField.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(12)
            make.leading.equalTo(lineView.snp.leading)
            make.trailing.equalTo(lineView.snp.trailing)
            make.height.equalTo(48)
        }
        stockAmountTextField.snp.makeConstraints { make in
            make.top.equalTo(stockPriceTextField.snp.bottom).offset(10)
            make.leading.equalTo(lineView.snp.leading)
            make.trailing.equalTo(lineView.snp.trailing)
            make.height.equalTo(48)
        }
        
        totalPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(stockAmountTextField.snp.bottom).offset(9)
            make.trailing.equalTo(self.snp.trailing)
            make.width.equalTo(84)
            make.height.equalTo(15)
        }
        
        totalPriceValue.snp.makeConstraints { make in
            make.top.equalTo(totalPriceLabel.snp.bottom).offset(2)
            make.trailing.equalTo(self.snp.trailing)
            make.width.greaterThanOrEqualTo(18)
            make.height.equalTo(24)
        }
        
    }

    override func bind() {
        self.totalPriceValue.text = "0"
    }
    
    
    
    
    
}
