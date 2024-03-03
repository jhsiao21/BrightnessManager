//
//  HomeViewController.swift
//  BrightnessManager
//
//  Created by LoganMacMini on 2024/3/2.
//

import UIKit

class HomeViewController: UIViewController {

    let titleLabel = UILabel()
            
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(titleLabel)
        
        style()
        layout()
    }
    
    private func style() {
        titleLabel.text = "HomeViewController"
        titleLabel.font = .boldSystemFont(ofSize: 30)
        titleLabel.textColor = .secondarySystemBackground
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        view.backgroundColor = .systemBackground
    }
    
    private func layout() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("HomeViewController viewWillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        print("HomeViewController viewWillDisappear")
    }
}
