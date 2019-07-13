//
//  NextViewController.swift
//  SiriCustomIntents
//
//  Created by Badarinath Venkatnarayansetty on 7/13/19.
//  Copyright © 2019 Badarinath Venkatnarayansetty. All rights reserved.
//

import Foundation
import UIKit

class NextViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.yellow
        
        self.navigationItem.title = "Back"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("After view appeared")
    }
}

extension UINavigationController {
    func replaceCurrentViewController(with viewController: UIViewController, animated: Bool) {
        let indexToRemove = viewControllers.count - 2
        if indexToRemove >= 0 {
            viewControllers.remove(at: indexToRemove)
        }
        
        pushViewController(viewController, animated: animated)
    }
}
