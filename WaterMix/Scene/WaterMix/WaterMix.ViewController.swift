//
//  WaterMix.ViewController.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//
import UIKit

extension WaterMix {
    
    final class ViewController : UIViewController {
        
        override func loadView() {
            super.loadView()
            self.view = WaterMix.RootView(viewModel: WaterMix.ViewModel())
        }
        override func viewDidLayoutSubviews() {
            super.viewDidLayoutSubviews()
            self.navigationController?.isNavigationBarHidden = true
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
             self.view.endEditing(true)
         }
    }
    
}
