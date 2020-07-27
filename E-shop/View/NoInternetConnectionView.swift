//
//  NoInternetConnectionView.swift
//  E-shop
//
//  Created by Vyacheslav on 06.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class NoInternetConnectionView: UIView {

    private lazy var connectionImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "unavailable")
        imageView.backgroundColor = .clear
        return imageView
    }()
    
    private lazy var connectionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Bold", size: 17)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "No internet connection"
        return label
    }()
    
    private lazy var connectionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [self.connectionImageView, self.connectionLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setupAppearance() {
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: -10, height: 0)
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity =  0.25
    }
    
    func setupConstraints() {
        self.addSubview(connectionStackView)
        NSLayoutConstraint.activate([
            connectionStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10),
            connectionStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            connectionStackView.heightAnchor.constraint(equalToConstant: 50),
            
            connectionImageView.widthAnchor.constraint(equalToConstant: 50),
        ])
    }
}
