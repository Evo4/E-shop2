//
//  ReviewCell.swift
//  E-shop
//
//  Created by Vyacheslav on 02.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class ReviewCell: UICollectionViewCell {
    
    private lazy var userLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Bold", size: 17)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        return label
    }()
    
    let rateButons:[UIButton] = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.rateButons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 3
        return stackView
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = UIFont(name: "Raleway-Regular", size: 17)
        textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textView.isEditable = false
        textView.backgroundColor = .clear
        return textView
    }()
    
    var review: Review? {
        didSet {
            guard let review = self.review else {return}
            userLabel.text = review.created_by.username
            reviewTextView.text = review.text
            setupRateButtons(rate: review.rate)
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0.7689999938, blue: 0.2469999939, alpha: 0.25)
        self.layer.cornerRadius = 10
    }
    
    func setupConstraints() {
        [userLabel, rateStackView, reviewTextView].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            userLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            userLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            
            rateStackView.topAnchor.constraint(equalTo: userLabel.bottomAnchor, constant: 3),
            rateStackView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 8),
            rateStackView.heightAnchor.constraint(equalToConstant: 12),

            reviewTextView.topAnchor.constraint(equalTo: rateStackView.bottomAnchor, constant: 8),
            reviewTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            reviewTextView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5),
            reviewTextView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -5),
        ])
    }
    
    func setupRateButtons(rate: Int) {
        if rate > 0 {
            for i in 0..<rate {
                rateButons[i].setImage(#imageLiteral(resourceName: "filled_star").withRenderingMode(.alwaysTemplate), for: .normal)
            }
            for i in rate..<rateButons.count {
                rateButons[i].setImage(#imageLiteral(resourceName: "star").withRenderingMode(.alwaysTemplate), for: .normal)
            }
            rateButons.forEach { (button) in
                button.tintColor = #colorLiteral(red: 0.9960784314, green: 0.5098039216, blue: 0.02745098039, alpha: 1)
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: 12),
                ])
            }
        } else {
            rateButons.forEach { (button) in
                button.setImage(#imageLiteral(resourceName: "star").withRenderingMode(.alwaysTemplate), for: .normal)
                button.tintColor = #colorLiteral(red: 0.9960784314, green: 0.5098039216, blue: 0.02745098039, alpha: 1)
                NSLayoutConstraint.activate([
                    button.widthAnchor.constraint(equalToConstant: 12),
                ])
            }
        }
    }
}
