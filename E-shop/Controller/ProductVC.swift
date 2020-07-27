//
//  ProductVC.swift
//  E-shop
//
//  Created by Vyacheslav on 31.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit
import Reachability

class ProductVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    
    private lazy var addReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add review", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17)
        button.addTarget(self, action: #selector(openNewReviewVC), for: .touchUpInside)
        button.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        return button
    }()
    
    private lazy var imageShadowView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.25
        return view
    }()
    
    private lazy var productImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var productCardView: ProductCardView = {
        let view = ProductCardView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var product: Product? {
        didSet {
            guard let p = self.product,
                let url = URL(string: "http://smktesting.herokuapp.com/static/" + p.img) else {return}
            Service.shared.downloadImage(from: url) { (data) in
                self.productImageView.image = UIImage(data: data)
            }
            productCardView.titleLabel.text = p.title
            productCardView.descriptionLabel.text = p.text
            self.getReviews(productID: p.id)
        }
    }
    
    var user: User?
    var isCached: Bool?
    
    private var reachability : Reachability!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupConstraints()
        observeReachability()
    }
    
    func setupAppearance() {
        view.backgroundColor = #colorLiteral(red: 0.949000001, green: 0.9610000253, blue: 0.9840000272, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1)
        self.navigationController?.navigationBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        let rightBarButton = UIBarButtonItem(customView: addReviewButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
    }

    func setupConstraints() {
        [productCardView, imageShadowView].forEach { (subview) in
            view.addSubview(subview)
        }
        imageShadowView.addSubview(productImageView)
        NSLayoutConstraint.activate([
            imageShadowView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageShadowView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            imageShadowView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            imageShadowView.heightAnchor.constraint(equalTo: productImageView.widthAnchor, multiplier: 0.8),
            
            productImageView.topAnchor.constraint(equalTo: imageShadowView.topAnchor),
            productImageView.bottomAnchor.constraint(equalTo: imageShadowView.bottomAnchor),
            productImageView.leftAnchor.constraint(equalTo: imageShadowView.leftAnchor),
            productImageView.rightAnchor.constraint(equalTo: imageShadowView.rightAnchor),
            
            productCardView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            productCardView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: -30),
            productCardView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            productCardView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
    
    func getReviews(productID: Int) {
        Service.shared.getProductReviews(productID: productID) { (reviews) in
            DispatchQueue.main.async {
                let sortedReviews = reviews.sorted(by: {$0.id > $1.id})
                self.productCardView.reviews = sortedReviews
                Service.shared.serializeReviews(reviews: sortedReviews, productID: productID)
            }
        }
    }
    
    @objc func openNewReviewVC() {
        let newReviewVC = NewReviewVC()
        newReviewVC.productId = product?.id
        let navController = UINavigationController(rootViewController: newReviewVC)
        self.present(navController, animated: true, completion: nil)
        
        newReviewVC.dismissVCCallback = { [weak self] in
            guard let id = self?.product?.id else {return}
            self?.getReviews(productID: id)
        }
    }
    
    func observeReachability(){
        self.reachability = try! Reachability()
        NotificationCenter.default.addObserver(self, selector:#selector(self.reachabilityChanged), name: NSNotification.Name.reachabilityChanged, object: nil)
        do {
            try self.reachability.startNotifier()
        }
        catch(let error) {
            print("Error occured while starting reachability notifications : \(error.localizedDescription)")
        }
    }

    @objc func reachabilityChanged(note: Notification) {
        let reachability = note.object as! Reachability
        DispatchQueue.main.async { [weak self] in
            switch reachability.connection {
            case .cellular, .wifi:
                break
            case .unavailable:
                guard let isCached = self?.isCached else {return}
                if self?.user != nil && isCached {
                    guard let product = self?.product,
                        let reviews = Service.shared.deserializeReviews(productID: product.id) else {return}
                    self?.productCardView.reviews = reviews
                    self?.productCardView.reviewsCollectionView.reloadData()
                }
                break
            case .none:
                break
            }
        }
    }
}
