//
//  AlertView.swift
//  E-shop
//
//  Created by Vyacheslav on 04.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

enum AlertType {
    case done
    case error
}

class AlertView: UIView {

    lazy var alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var alertLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Bold", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    var alertType: AlertType? {
        didSet {
            guard let alertType = self.alertType else {return}
            switch alertType {
            case .done:
                self.alertImageView.image = #imageLiteral(resourceName: "checkmark")
                break
            case .error:
                self.alertImageView.image = #imageLiteral(resourceName: "exclamation_mark")
                break
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupConstrains()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupAppearance() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity =  0.25
        self.layer.cornerRadius = 10
    }
    
    func setupConstrains() {
        [alertImageView, alertLabel].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            alertImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            alertImageView.widthAnchor.constraint(equalToConstant: 50),
            alertImageView.heightAnchor.constraint(equalToConstant: 50),
            
            alertLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            alertLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
            alertLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            alertLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10)
        ])
    }
}
