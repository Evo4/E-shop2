//
//  ProductCardView.swift
//  E-shop
//
//  Created by Vyacheslav on 02.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class ProductCardView: UIView {

    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Regular", size: 27)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Regular", size: 20)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.6)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var reviewsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: SnapPagingLayout(
            centerPosition: true,
            peekWidth: 40,
            spacing: 20,
            inset: 16
        ))
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    
    var reviews: [Review] = [] {
        didSet {
            self.reviewsCollectionView.reloadData()
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
        self.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        self.layer.cornerRadius = 15
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.layer.shadowRadius = 15
        self.layer.shadowOpacity = 0.25
        
        reviewsCollectionView.register(ReviewCell.self, forCellWithReuseIdentifier: "cell")
        reviewsCollectionView.delegate = self
        reviewsCollectionView.dataSource = self
    }
    
    func setupConstraints() {
        [titleLabel, descriptionLabel, reviewsCollectionView].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 55),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 7),
            descriptionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            
            reviewsCollectionView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            reviewsCollectionView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20),
            reviewsCollectionView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20),
            reviewsCollectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
    
   
}

extension ProductCardView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return reviews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? ReviewCell {
            let review = reviews[indexPath.row]
            cell.review = review
            return cell
        }
        return UICollectionViewCell()
    }

    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        guard let layout = reviewsCollectionView.collectionViewLayout as? SnapPagingLayout else { return }
        layout.willBeginDragging()
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let layout = reviewsCollectionView.collectionViewLayout as? SnapPagingLayout else { return }
        layout.willEndDragging(withVelocity: velocity, targetContentOffset: targetContentOffset)
    }

}
