//
//  ViewController.swift
//  BrightnessManager
//
//  Created by LoganMacMini on 2024/3/2.
//

import UIKit

class DemoViewController: UITabBarController {
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let vc1 = UINavigationController(rootViewController: HomeViewController())
        let vc2 = UINavigationController(rootViewController: ShowBarcodeViewController())
        
        vc1.tabBarItem.image = UIImage(systemName: "house.fill")?.withRenderingMode(.automatic)
        vc2.tabBarItem.image = UIImage(systemName: "qrcode")?.withRenderingMode(.automatic)
        vc1.title = "Home"
        vc2.title = "Barcode"
        
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .black
        tabBar.isTranslucent = false
        
        tabBar.shadowImage = UIImage()
        setViewControllers([vc1, vc2], animated: true)
    }
}

