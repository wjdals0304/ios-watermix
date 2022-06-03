//
//  WaterMix.ViewController.swift
//  WaterMix
//
//  Created by 김정민 on 2022/06/03.
//

import Foundation
import UIKit

extension WaterMix {
    
    final class ViewController : UIViewController {
        
        override func loadView() {
            super.loadView()
            self.view = WaterMix.RootView()
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = "물타기 계산기"
            
        }
        
    }
    
}
