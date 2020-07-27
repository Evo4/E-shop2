//
//  SideMenuCell.swift
//  E-shop
//
//  Created by Vyacheslav on 31.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class SideMenuCell: UITableViewCell {

    private lazy var itemImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var itemNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Regular", size: 17)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    private lazy var button: UIButton = {
        let b = UIButton()
        b.translatesAutoresizingMaskIntoConstraints = false
        b.addTarget(self, action: #selector(sideMenuAction), for: .touchUpInside)
        return b
    }()
    
    var callback: (()->())?
    var menuItem: MenuItem? {
        didSet {
            guard let item = self.menuItem else {return}
            itemImageView.image = item.image
            itemNameLabel.text = item.name
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupAppearance()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupAppearance() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setupConstraints() {
        [itemImageView, itemNameLabel, button].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            itemImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            itemImageView.widthAnchor.constraint(equalToConstant: 20),
            itemImageView.heightAnchor.constraint(equalToConstant: 20),
            
            itemNameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            itemNameLabel.leftAnchor.constraint(equalTo: itemImageView.rightAnchor, constant: 15),
            
            button.topAnchor.constraint(equalTo: self.topAnchor),
            button.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            button.leftAnchor.constraint(equalTo: self.leftAnchor),
            button.rightAnchor.constraint(equalTo: self.rightAnchor),
        ])
    }
    
    @objc func sideMenuAction() {
        callback?()
    }
}
