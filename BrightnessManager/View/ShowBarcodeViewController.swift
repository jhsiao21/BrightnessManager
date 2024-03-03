//
//  MemberViewController.swift
//  BrightnessManager
//
//  Created by LoganMacMini on 2024/3/2.
//

import UIKit

class ShowBarcodeViewController: UIViewController {
    
    private let showBarcodeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "barcode"), for: .normal)
        button.tintColor = .systemBackground
        button.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        button.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(showBarcodeButton)
        
        view.backgroundColor = .systemBackground
        
        NSLayoutConstraint.activate([
            showBarcodeButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showBarcodeButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            showBarcodeButton.widthAnchor.constraint(equalToConstant: 50),
            showBarcodeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        showBarcodeButton.layer.cornerRadius = showBarcodeButton.frame.width / 2
    }
    
    @objc func searchButtonTapped() {
//        let vc = CodeViewController()
//        vc.modalPresentationStyle = .popover
//        present(vc, animated: false)
        
        PopUpBarcodeViewController.present(initialView: self, delegate: self)
    }
}

extension ShowBarcodeViewController: PopUpBarcodeDelegate {
    func didTapClose() {
        self.dismiss(animated: true)
    }
    
    func didTapChangeCode() {
        
    }    
    
}
