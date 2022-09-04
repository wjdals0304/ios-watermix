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
        
            calCurrentTotalPrice = Observable.combineLatest(
                currentStockPrice,
                currentStockAmount,
                resultSelector: { (price, amount) in
                    return price * amount
                }
            )
            
            addTotalPrice = Observable.combineLatest(
                addStockPrice,
                addStockAmount,
                resultSelector: { price, amount in
                    return price * amount
                }
            )
            
            
            totalPrice = Observable.combineLatest(
                calCurrentTotalPrice,
                addTotalPrice,
                resultSelector: { currentTotalPrice, addTotalPrice in
                    return Float(currentTotalPrice + addTotalPrice)
                }
            )
            
            totalAmount = Observable.combineLatest(
                currentStockAmount,
                addStockAmount,
                resultSelector: { currentAmount , addAmount in
                    return Int(currentAmount + addAmount)
                }
            )
            
            totalPurchasePrice = Observable.combineLatest(
                totalPrice,
                totalAmount,
                resultSelector: { totalPrice, totalAmount in
                    if totalAmount == 0 {
                        return 0.0
                    }
                    return Float64(totalPrice / Float(totalAmount))
                }
            )

            totalRatio = Observable.combineLatest(
                currentMarketPrice,
                totalPurchasePrice,
                resultSelector:  { marketPrice, purchasePrice in
                    return Float( ( (Double(marketPrice) - purchasePrice ) / purchasePrice )  * 100 )
                }
            )
            
            proAndLoss = Observable.combineLatest(
                totalPrice,
                totalRatio,
                resultSelector: { totalPrice, ratio in
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
