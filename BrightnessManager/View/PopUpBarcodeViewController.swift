//
//  PopUpBarcodeViewController.swift
//  BrightnessManager
//
//  Created by LoganMacMini on 2024/3/3.
//

import UIKit

protocol PopUpBarcodeDelegate: AnyObject {
    func didTapClose()
//    func didTapChangeCode()
}

class PopUpBarcodeViewController: UIViewController {
    
    var isShowMember : Bool = true
    weak var delegate: PopUpBarcodeDelegate?
    var barcodeShowUpManager : BrightnessManager? = nil
    
    init(delegate: PopUpBarcodeDelegate? = nil) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private static func create(delegate: PopUpBarcodeDelegate) -> PopUpBarcodeViewController {
        let view = PopUpBarcodeViewController(delegate: delegate)
        return view
    }
    
    @discardableResult
    static func present(initialView: UIViewController, delegate: PopUpBarcodeDelegate) -> PopUpBarcodeViewController {
        let view = PopUpBarcodeViewController.create(delegate: delegate)
        view.modalPresentationStyle = .overFullScreen
        view.modalTransitionStyle = .crossDissolve
        initialView.present(view, animated: true)
        return view
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        setupDismissTapGesture()
        setBarcodeShowUp()
    }
    
    private let canvas: UIView = {
        let view = UIStackView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "會員條碼"
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "memberCode"))
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var changeCodeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 1
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(self.didTapChangeCode(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.setTitle("關閉", for: .normal)
        button.backgroundColor = .systemPink
        button.addTarget(self, action: #selector(self.didTapClose(_:)), for: .touchUpInside)
        return button
    }()
    
    private func layout() {
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        view.addSubview(canvas)
        canvas.addSubview(titleLabel)
        canvas.addSubview(imageView)
        canvas.addSubview(changeCodeButton)
        canvas.addSubview(closeButton)
        
        NSLayoutConstraint.activate([
            canvas.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            canvas.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            canvas.widthAnchor.constraint(equalToConstant: view.bounds.width * 0.8),
            canvas.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.45),
            
            titleLabel.topAnchor.constraint(equalTo: canvas.topAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: 50),
            
            imageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: canvas.leadingAnchor, constant: 20),
            imageView.trailingAnchor.constraint(equalTo: canvas.trailingAnchor, constant: -20),
            imageView.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 150),
            
            changeCodeButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            changeCodeButton.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            changeCodeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: canvas.leadingAnchor, multiplier: 2),
            canvas.trailingAnchor.constraint(equalToSystemSpacingAfter: changeCodeButton.trailingAnchor, multiplier: 2),
            changeCodeButton.heightAnchor.constraint(equalToConstant: 50),
            
            closeButton.topAnchor.constraint(equalTo: changeCodeButton.bottomAnchor, constant: 15),
            closeButton.leadingAnchor.constraint(equalToSystemSpacingAfter: canvas.leadingAnchor, multiplier: 2),
            canvas.trailingAnchor.constraint(equalToSystemSpacingAfter: closeButton.trailingAnchor, multiplier: 2),
            closeButton.centerXAnchor.constraint(equalTo: canvas.centerXAnchor),
            closeButton.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        setupBtnWhenDisplayMemberCode()
    }
    
    @objc func didTapClose(_ btn: UIButton) {
        self.delegate?.didTapClose()
    }
    
    @objc func didTapChangeCode(_ btn: UIButton) {
//        self.delegate?.didTapChangeCode()
        isShowMember.toggle()
        
        if isShowMember {
            setupBtnWhenDisplayMemberCode()
        } else {
            setupBtnWhenDisplayBarCode()
        }
    }
    
    private func setBarcodeShowUp() {
        barcodeShowUpManager = BrightnessManager()
        
        //指定WillEnterForeground觸發的函式為此view controller的willEnterForeground()
        barcodeShowUpManager?.setWillEnterForeground {
            self.willEnterForeground()
        }
        //指定WillResignActive觸發的函式為此view controller的willResignActive()
        barcodeShowUpManager?.setWillResignActive {
            self.willResignActive()
        }
    }
    
    private func willEnterForeground() {
        print("PopUpBarcodeViewController willEnterForeground")
        barcodeShowUpManager?.setBrightnessToMax()
    }
    
    private func willResignActive() {
        print("PopUpBarcodeViewController willResignActive")
        barcodeShowUpManager?.setBrightnessToOriginal()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        barcodeShowUpManager?.setBrightnessToMax()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        barcodeShowUpManager?.setBrightnessToOriginal()
        barcodeShowUpManager = nil
    }
    
    private func setupBtnWhenDisplayMemberCode() {
        canvas.backgroundColor = .white
        titleLabel.text = "會員條碼"
        titleLabel.textColor = .black
        imageView.image = UIImage(named: "memberCode")
                
        changeCodeButton.layer.borderColor = UIColor.systemPink.cgColor
        changeCodeButton.setTitleColor(.systemPink, for: .normal)
        changeCodeButton.setTitle("顯示手機條碼載具", for: .normal)
    }
    
    private func setupBtnWhenDisplayBarCode() {
        canvas.backgroundColor = .systemPink
        titleLabel.text = "手機條碼載具"
        titleLabel.textColor = .white
        imageView.image = UIImage(named: "receiptCode")
        
        changeCodeButton.layer.borderColor = UIColor.white.cgColor
        changeCodeButton.setTitleColor(.systemPink, for: .normal)
        changeCodeButton.setTitle("顯示會員條碼", for: .normal)
    }
    
    private func setupDismissTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.dismissController(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }

    @objc func dismissController(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self.view)
        if !canvas.frame.contains(location) {
            self.delegate?.didTapClose()
        }
    }
}
