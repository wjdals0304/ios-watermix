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

extension WaterMix {
    
    final class RootView: BaseUIView {
        
        let disposeBag = DisposeBag()
        private let viewModel: WaterMixModelType
        
        private lazy var scrollView: UIScrollView = {
           let scrollView = UIScrollView()
            scrollView.showsVerticalScrollIndicator = false
            scrollView.isScrollEnabled = true
            return scrollView
        }()
        private let contentView = UIView()

        
        private let headerView = UIView()
        private let titleLabel: UILabel = {
           let label = UILabel()
            label.text = L10n.title.description
            label.textColor = UIColor.black
            label.font = UIFont.boldSystemFont(ofSize: 18)
            return label
        }()
        
        private let arrowButton: UIButton = {
            let button = UIButton()
            button.setImage(UIImage.undoArrow1, for: .normal)
            return button
        }()
        
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
                headerView,
                scrollView
            ].forEach { self.addSubview($0) }
                        
            scrollView.addSubview(contentView)
            
            [
                totalAccountView,
                currentStockView,
                stockAddView
            ].forEach { contentView.addSubview($0)}
            
            
            [
             titleLabel,
             arrowButton
            ].forEach { self.headerView.addSubview($0)}
            
            let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
            contentView.addGestureRecognizer(tap)
        }
        
        override func setupConstraints() {
            
            scrollView.snp.makeConstraints { make in
                make.centerX.equalTo(self.snp.centerX)
                make.width.equalTo(self.snp.width)
                make.top.equalTo(self.headerView.snp.bottom)
                make.bottom.equalTo(self.safeAreaLayoutGuide).inset(5)
            }
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView.contentLayoutGuide)
                make.height.greaterThanOrEqualTo(self.snp.height).priority(.low)
                make.width.equalTo(scrollView.snp.width)
                make.centerX.equalTo(scrollView.snp.centerX)
            }
            
            headerView.snp.makeConstraints { make in
                make.top.equalTo(self.safeAreaLayoutGuide)
                make.leading.equalToSuperview().offset(15)
                make.trailing.equalToSuperview().inset(16)
                make.height.equalTo(22)
            }
            
            titleLabel.snp.makeConstraints { make in
                make.center.equalTo(self.headerView.snp.center)
            }
            
            arrowButton.snp.makeConstraints { make in
                make.top.trailing.equalToSuperview()
                make.width.height.equalTo(22)
            }
            
            totalAccountView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(15)
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
        @objc func dismissKeyboard() {
            //Causes the view (or one of its embedded text fields) to resign the first responder status.
            contentView.endEditing(true)
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
                .distinctUntilChanged()
                .bind { [weak self] in
                    if $0 == 0 {
                        self?.currentStockView.totalPriceValue.textColor = UIColor.black
                    }
                    self?.currentStockView.totalPriceValue.text = $0.withCommas()
                }
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
            
            viewModel.getAddTotalPrice
                .distinctUntilChanged()
                .bind { [weak self] in
                    self?.stockAddView.totalPriceValue.text = $0.withCommas()
                }
                .disposed(by: disposeBag)
            
            viewModel.getTotalPrice
                .distinctUntilChanged()
                .bind { [weak self] in
                    self?.totalAccountView.totalPriceValue.text = $0.withCommas()
                }
                .disposed(by: disposeBag)
            
            
            viewModel.getTotalAmount
                .map { String($0) }
                .distinctUntilChanged()
                .bind(to: totalAccountView.totalAmountValue.rx.text)
                .disposed(by: disposeBag)
            
            viewModel.getTotalPurchasePrice
                .distinctUntilChanged()
                .bind { [weak self] in
                    if $0 == 0 {
                        self?.totalAccountView.totalStockValue.textColor = UIColor.black
                    } else {
                        self?.totalAccountView.totalStockValue.textColor = UIColor.ff5C00
                    }
                    self?.totalAccountView.totalStockValue.text = Int64($0).withCommas()
                }
                .disposed(by: disposeBag)
            
            viewModel.getTotalRatio
                .distinctUntilChanged()
                .bind{ [weak self] in
                    if $0 > 0  {
                        self?.totalAccountView.proAndLossRatioValue.textColor = UIColor.ff0F00
                        self?.totalAccountView.proAndLossRatioValue.text = String(format: "%.2f %%", $0)
                    } else if $0 == 0 {
                        self?.totalAccountView.proAndLossRatioValue.textColor = UIColor.black
                        self?.totalAccountView.proAndLossRatioValue.text = "0"
                    } else {
                        self?.totalAccountView.proAndLossRatioValue.textColor = UIColor._0075Ff
                        self?.totalAccountView.proAndLossRatioValue.text = String(format: "%.2f %%", $0)
                    }
                }
                .disposed(by: disposeBag)
            
            viewModel.getProAndLoss
                .distinctUntilChanged()
                .bind { [weak self] in
                    self?.totalAccountView.proAndLossValue.text = $0.withCommas()
                }
                .disposed(by: disposeBag)
            
            arrowButton.rx.tap
                .bind { [weak self] in
                    self?.viewModel.getAddStockPrice.accept(0)
                    self?.viewModel.getAddStockAmount.accept(0)
                    
                    self?.currentStockView.stockMarketPriceField.text = ""
                    self?.currentStockView.stockPriceTextField.text = ""
                    self?.currentStockView.stockAmountTextField.text = ""
                    self?.currentStockView.totalPriceValue.text = "0"
                    
                    self?.stockAddView.stockAmountTextField.text = ""
                    self?.stockAddView.stockPriceTextField.text = ""
                    self?.stockAddView.totalPriceValue.text = "0"
                    
                    self?.totalAccountView.totalStockValue.text = "0"
                    self?.totalAccountView.totalPriceValue.text = "0"
                    self?.totalAccountView.totalAmountValue.text = "0"
                    self?.totalAccountView.proAndLossRatioValue.text = "0"
                    self?.totalAccountView.proAndLossValue.text = "0"
                    
                    self?.totalAccountView.totalStockValue.textColor = UIColor.black
                    self?.totalAccountView.proAndLossRatioValue.textColor = UIColor.black
                    
                }.disposed(by: disposeBag)
        }
    }
}
