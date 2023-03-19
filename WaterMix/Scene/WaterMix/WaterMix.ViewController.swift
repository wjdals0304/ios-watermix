//
//  WaterMix.ViewController.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//
import UIKit
import GoogleMobileAds
import AdSupport

extension WaterMix {
    
    final class ViewController : UIViewController {
        
        private let viewModel = WaterMix.ViewModel()
        private lazy var rootView = WaterMix.RootView(viewModel: viewModel)
        
        override func loadView() {
            super.loadView()
            self.view = rootView
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            self.navigationController?.isNavigationBarHidden = true
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            loadFrontAd()
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             self.view.endEditing(true)
         }
    }
    
}


extension WaterMix.ViewController: GADFullScreenContentDelegate {
    func loadFrontAd() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: Helper.ADMOB_REFRESH_FRONT_ID,
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            rootView.interstitial = ad
            rootView.interstitial?.fullScreenContentDelegate = self
        }
        )
    }
}
