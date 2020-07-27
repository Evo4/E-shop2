//
//  ProductCell.swift
//  E-shop
//
//  Created by Vyacheslav on 30.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Regular", size: 17)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Regular", size: 14)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(openProductPageAction), for: .touchUpInside)
        return b
    }()
    
    var callback: (()->())?
    var product: Product? {
        didSet {
            guard let p = self.product,
                let url = URL(string: "http://smktesting.herokuapp.com/static/" + p.img) else {return}
            Service.shared.downloadImage(from: url) { (data) in
                self.productImageView.image = UIImage(data: data)
            }
            titleLabel.text = p.title
            descriptionLabel.text = p.text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupAppearance() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    func setupConstraints() {
        [productImageView, titleLabel, descriptionLabel, button].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            productImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            productImageView.leftAnchor.constraint(equalTo: self.leftAnchor),
            productImageView.rightAnchor.constraint(equalTo: self.rightAnchor),
            productImageView.heightAnchor.constraint(equalToConstant: self.frame.height * 0.6),
            
            titleLabel.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 5),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            titleLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            descriptionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
            
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    @objc func openProductPageAction() {
        callback?()
    }
}
