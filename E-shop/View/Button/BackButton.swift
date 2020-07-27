//
//  BackButton.swift
//  E-shop
//
//  Created by Vyacheslav on 29.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class BackButton: UIButton {

    private lazy var backButtonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "back_arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func configureButton() {
        self.addSubview(backButtonImage)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 25),
            self.widthAnchor.constraint(equalToConstant: 25),
            backButtonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            backButtonImage.leftAnchor.constraint(equalTo: self.leftAnchor),
            backButtonImage.heightAnchor.constraint(equalToConstant: 18),
            backButtonImage.widthAnchor.constraint(equalToConstant: 21),
        ])
    }

}
