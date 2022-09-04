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
            self.view = WaterMix.RootView(viewModel: WaterMix.ViewModel())
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
            title = L10n.title.description
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage.undoArrow1, style: .plain, target: nil, action: nil)
            self.navigationItem.rightBarButtonItem?.tintColor = UIColor._181818
        }
        
    }
    
}
