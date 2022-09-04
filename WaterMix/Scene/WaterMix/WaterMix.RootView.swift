//
//  WaterMix.RootView.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//
import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Foundation

extension WaterMix {
    
    final class RootView: BaseUIView {
        
        let disposeBag = DisposeBag()
        private let viewModel: WaterMixModelType
        
        private let totalAccountView = TotalAccountView()
        
        private let currentStockView = StockCurrentView(title: L10n.currentStock.description, stockMarketPrice: L10n.currentMarketPrice.description, stockPriceText: L10n.currentStockPrice.description, sotckAmountText: L10n.currentStockAmount.description, totalPriceText: L10n.currentStockTotalPrice.description)
        
        
        private let stockAddView = StockAddView(title: L10n.addStock.description, stockPriceText: L10n.addStockPrice.description, sotckAmountText: L10n.addStockAmount.description, totalPriceText: L10n.addStockTotalPrice.description)
                
        init(viewModel: WaterMixModelType) {
            self.viewModel = viewModel
            super.init(frame: .zero)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override func setup() {
            
            [
                totalAccountView,
                currentStockView,
                stockAddView
            ].forEach { self.addSubview($0) }
            
        }
        
        override func setupConstraints() {
            totalAccountView.snp.makeConstraints { make in
                make.top.equalTo(self.safeAreaLayoutGuide).offset(18)
                make.leading.equalToSuperview().offset(15)
                make.width.equalTo(self).multipliedBy(0.92)
                make.height.equalTo(200)
            }
            
            currentStockView.snp.makeConstraints { make in
                make.top.equalTo(totalAccountView.snp.bottom).offset(33)
                make.leading.equalToSuperview().offset(15)
                make.width.equalTo(self).multipliedBy(0.92)
                make.height.equalTo(250)
            }
            
            stockAddView.snp.makeConstraints { make in
                make.top.equalTo(currentStockView.snp.bottom).offset(30)
                make.leading.equalToSuperview().offset(15)
                make.width.equalTo(self).multipliedBy(0.92)
                make.height.equalTo(250)
                
            }
        }
        
        override func bind() {
            
            currentStockView.stockMarketPriceField.rx.text.orEmpty
                .map { UInt64($0) ?? 0 }
                .bind(to: viewModel.getCurrentMarketPrice)
                .disposed(by: disposeBag)
            
            currentStockView.stockPriceTextField.rx.text.orEmpty
                .map { UInt64($0) ?? 0 }
                .bind(to: viewModel.getCurrentStockPrice)
                .disposed(by: disposeBag)
            
            currentStockView.stockAmountTextField.rx.text.orEmpty
                .map { UInt64($0) ?? 0 }
                .bind(to: viewModel.getcurrentStockAmount)
                .disposed(by: disposeBag)
                        
            viewModel.getCalCurrentTotatlPrice
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: currentStockView.totalPriceValue.rx.text)
                .disposed(by: disposeBag)
            
            
            stockAddView.stockPriceTextField.rx.text.orEmpty
                .map { UInt64($0) ?? 0 }
                .bind(to: viewModel.getAddStockPrice)
                .disposed(by: disposeBag)
            
            stockAddView.stockAmountTextField.rx.text.orEmpty
                .map { UInt64($0) ?? 0 }
                .bind(to: viewModel.getAddStockAmount)
                .disposed(by: disposeBag)
            
            
            viewModel.getAddTotalPrice
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: stockAddView.totalPriceValue.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.getTotalPrice
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: totalAccountView.totalPriceValue.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.getTotalAmount
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: totalAccountView.totalAmountValue.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.getTotalPurchasePrice
                .distinctUntilChanged()
                .bind { [weak self] in
                    self?.totalAccountView.totalStockValue.text = Int64($0).withCommas()
                    self?.totalAccountView.totalStockValue.textColor = UIColor.ff5C00
                }
                .disposed(by: disposeBag)
            
            viewModel.getTotalRatio
                .distinctUntilChanged()
                .bind{ [weak self] in
                    self?.totalAccountView.proAndLossRatioValue.text = String(format: "%.2f %%", $0)
                    if $0 > 0  {
                        self?.totalAccountView.proAndLossRatioValue.textColor = UIColor.ff0F00
                    } else {
                        self?.totalAccountView.proAndLossRatioValue.textColor = UIColor._0075Ff
                    }
                    
                }
                .disposed(by: disposeBag)
            
            viewModel.getProAndLoss
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: totalAccountView.proAndLossValue.rx.text)
                .disposed(by: disposeBag)
        }
    }
}
