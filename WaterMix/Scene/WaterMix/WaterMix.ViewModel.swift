//
//  WaterMix.ViewModel.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import Foundation
import RxCocoa
import RxSwift 

protocol WaterMixModelType {
    
    var getTotalPurchasePrice: Observable<Float64> { get }
    var getTotalPrice: Observable<Float> { get }
    var getTotalAmount: Observable<Int> { get }
    var getTotalRatio: Observable<Float> { get }
    var getProAndLoss: Observable<Float> { get }
    
    var getCurrentMarketPrice: PublishRelay<UInt64> { get }
    var getCurrentStockPrice: PublishRelay<UInt64> { get }
    var getcurrentStockAmount: PublishRelay<UInt64> { get }
    var getCalCurrentTotatlPrice: Observable<UInt64> { get }
    
    var getAddStockPrice: PublishRelay<UInt64> { get }
    var getAddStockAmount: PublishRelay<UInt64> { get }
    var getAddTotalPrice: Observable<UInt64> { get }
}

extension WaterMix {
    
    struct ViewModel {
        
        var totalPurchasePrice: Observable<Float64>
        var totalPrice: Observable<Float>
        var totalAmount : Observable<Int>
        var totalRatio: Observable<Float>
        var proAndLoss: Observable<Float>
                
        var currentMarketPrice = PublishRelay<UInt64>()
        var currentStockPrice = PublishRelay<UInt64>()
        var currentStockAmount = PublishRelay<UInt64>()
        var calCurrentTotalPrice: Observable<UInt64>
        
        var addStockPrice = PublishRelay<UInt64>()
        var addStockAmount = PublishRelay<UInt64>()
        var addTotalPrice: Observable<UInt64>

        init() {
            // MARK: 총 매입 금액
            calCurrentTotalPrice = Observable.combineLatest(
                currentStockPrice,
                currentStockAmount,
                resultSelector: { (price, amount) in
                    return price * amount
                }
            )
            // MARK: 추가 매수 총액
            addTotalPrice = Observable.combineLatest(
                addStockPrice,
                addStockAmount,
                resultSelector: { price, amount in
                    return price * amount
                }
            )
            
            // MARK: 최종 매수 금액
            totalPrice = Observable.combineLatest(
                calCurrentTotalPrice,
                addTotalPrice,
                calCurrentTotalPrice,
                resultSelector: { currentTotalPrice, addTotalPrice, calCurrentTotalPrice in
                    if calCurrentTotalPrice == 0 {
                        return 0
                    }
                    return Float(currentTotalPrice + addTotalPrice)
                }
            )
            // MARK: 최종 수량
            totalAmount = Observable.combineLatest(
                currentStockAmount,
                addStockAmount,
                calCurrentTotalPrice,
                resultSelector: { currentAmount , addAmount, calCurrentTotalPrice in
                    if calCurrentTotalPrice == 0 {
                        return 0
                    }
                    return Int(currentAmount + addAmount)
                }
            )
            // MARK: 최종 평단가
            totalPurchasePrice = Observable.combineLatest(
                totalPrice,
                totalAmount,
                calCurrentTotalPrice,
                resultSelector: { totalPrice, totalAmount, calCurrentTotalPrice in
                    if totalAmount == 0 || calCurrentTotalPrice == 0 {
                        return 0.0
                    }
                    return Float64(totalPrice / Float(totalAmount))
                }
            )
            // MARK: 손익률
            totalRatio = Observable.combineLatest(
                currentMarketPrice,
                totalPurchasePrice,
                addTotalPrice,
                calCurrentTotalPrice,
                resultSelector:  { marketPrice, purchasePrice, addTotalPrice, calCurrentTotalPrice in
                    if purchasePrice == 0 || addTotalPrice == 0 || calCurrentTotalPrice == 0 {
                        return 0
                    }
                    return Float( ( (Double(marketPrice) - purchasePrice ) / purchasePrice )  * 100 )
                }
            )
            // MARK: 손익금
            proAndLoss = Observable.combineLatest(
                totalPrice,
                totalRatio,
                calCurrentTotalPrice,
                resultSelector: { totalPrice, ratio, calCurrentTotalPrice in
                    if totalPrice == 0 || calCurrentTotalPrice == 0 {
                        return 0
                    }
                    return Float(totalPrice + ( totalPrice * ( 0.01 * ratio)) )
                }
            )
                
        }
        
    }
    
}

extension WaterMix.ViewModel: WaterMixModelType {
    var getTotalPurchasePrice: Observable<Float64> {
        return self.totalPurchasePrice
    }
    
    var getTotalPrice: Observable<Float> {
        return self.totalPrice
    }
    
    var getTotalAmount: Observable<Int> {
        return self.totalAmount
    }
    
    var getTotalRatio: Observable<Float> {
        return self.totalRatio
    }
    
    var getAddStockPrice: PublishRelay<UInt64> {
        return self.addStockPrice
    }
    
    var getAddStockAmount: PublishRelay<UInt64> {
        return self.addStockAmount
    }
    
    var getAddTotalPrice: Observable<UInt64> {
        return self.addTotalPrice
    }
    
    var getCurrentMarketPrice: PublishRelay<UInt64> {
        return self.currentMarketPrice
    }
    
    var getCurrentStockPrice : PublishRelay<UInt64> {
        return self.currentStockPrice
    }
    
    var getcurrentStockAmount : PublishRelay<UInt64> {
        return self.currentStockAmount
    }
    
    var getCalCurrentTotatlPrice: Observable<UInt64> {
        return self.calCurrentTotalPrice
    }
    
    var getProAndLoss: Observable<Float> {
        return self.proAndLoss
    }

        
}
