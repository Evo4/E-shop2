//
//  EnterButton.swift
//  E-shop
//
//  Created by Vyacheslav on 30.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class EnterButton: UIButton {

    private lazy var nextButtonImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "next_arrow")?.withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
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
        self.layer.cornerRadius = 20
        self.backgroundColor = #colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1)
        
        self.addSubview(nextButtonImage)
        
        NSLayoutConstraint.activate([
            self.heightAnchor.constraint(equalToConstant: 40),
            self.widthAnchor.constraint(equalToConstant: 40),
            nextButtonImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            nextButtonImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            nextButtonImage.heightAnchor.constraint(equalToConstant: 25),
            nextButtonImage.widthAnchor.constraint(equalToConstant: 25),
        ])
    }

}
