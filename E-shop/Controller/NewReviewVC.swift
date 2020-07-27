//
//  NewReviewVC.swift
//  E-shop
//
//  Created by Vyacheslav on 02.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class NewReviewVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .lightContent
    }
    
    let rateButons:[UIButton] = [UIButton(), UIButton(), UIButton(), UIButton(), UIButton()]
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var sendReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Bold", size: 17)
        button.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
        button.addTarget(self, action: #selector(sendReviewAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var rateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: self.rateButons)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 5
        return stackView
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Bold", size: 17)
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.text = "Review:"
        return label
    }()
    
    private lazy var reviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textView.font = UIFont(name: "Raleway-Regular", size: 17)
        textView.layer.cornerRadius = 10
        textView.layer.borderWidth = 1
        textView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        return textView
    }()
    var reviewTextViewBottomAnchor: NSLayoutConstraint!
    
    var rate: Int = 0
    var text: String = ""
    var productId: Int!
    var dismissVCCallback: (()->())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupConstraints()
        setupKeyboadObservers()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dismissVCCallback?()
    }
    
    func setupAppearance() {
        view.backgroundColor = #colorLiteral(red: 0.949000001, green: 0.9610000253, blue: 0.9840000272, alpha: 1)
        self.navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1)
        
        let navTitleLabel = UILabel()
        let navTitle = NSMutableAttributedString(string: "Review", attributes:[
            NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1),
            NSAttributedString.Key.font: UIFont(name: "Raleway-Bold", size: 17)!])
        navTitleLabel.attributedText = navTitle
        
        self.navigationItem.titleView = navTitleLabel
        
        let leftBarButton = UIBarButtonItem(customView: closeButton)
        self.navigationItem.leftBarButtonItem = leftBarButton
        
        let rightBarButton = UIBarButtonItem(customView: sendReviewButton)
        self.navigationItem.rightBarButtonItem = rightBarButton
        setupRateButtons()
    }
    
    func setupConstraints() {
        [rateStackView, reviewLabel, reviewTextView].forEach { (subview) in
            view.addSubview(subview)
        }
        reviewTextViewBottomAnchor = reviewTextView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        NSLayoutConstraint.activate([
            rateStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            rateStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            rateStackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            rateStackView.heightAnchor.constraint(equalToConstant: 40),
            
            reviewLabel.topAnchor.constraint(equalTo: rateStackView.bottomAnchor, constant: 10),
            reviewLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            
            reviewTextView.topAnchor.constraint(equalTo: reviewLabel.bottomAnchor, constant: 4),
            reviewTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            reviewTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            reviewTextViewBottomAnchor!
        ])
    }
    
    func setupRateButtons() {
        var tag = 1
        rateButons.forEach { (button) in
            button.tag = tag
            button.setImage(#imageLiteral(resourceName: "star").withRenderingMode(.alwaysTemplate), for: .normal)
            button.tintColor = #colorLiteral(red: 0.9960784314, green: 0.5098039216, blue: 0.02745098039, alpha: 1)
            NSLayoutConstraint.activate([
                button.widthAnchor.constraint(equalToConstant: 40),
            ])
            tag += 1
            button.addTarget(self, action: #selector(setRateAction(sender:)), for: .touchUpInside)
        }
    }
    
    @objc func setRateAction(sender: UIButton) {
        let rate = sender.tag
        self.rate = rate
        setupRateButtons(rate: rate)
    }
    
    func setupRateButtons(rate: Int) {
        for i in 0..<rate {
            rateButons[i].setImage(#imageLiteral(resourceName: "filled_star").withRenderingMode(.alwaysTemplate), for: .normal)
        }
        for i in rate..<rateButons.count {
            rateButons[i].setImage(#imageLiteral(resourceName: "star").withRenderingMode(.alwaysTemplate), for: .normal)
        }
        rateButons.forEach { (button) in
            button.tintColor = #colorLiteral(red: 0.9960784314, green: 0.5098039216, blue: 0.02745098039, alpha: 1)
        }
    }
    
    @objc func closeAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func sendReviewAction() {
        guard let user = Service.shared.deserializeUser() else {
            let text = "Sign in to post reviews"
            self.view.endEditing(true)
            showAlert(view: self.view, alertType: .error, text: text)
            return
        }
        if reviewTextView.text.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            text = reviewTextView.text
             
            Service.shared.postReview(productID: productId, userToken: user.token, rate: rate, text: text)
            
            let text = "Review posted"
            self.view.endEditing(true)
            showAlert(view: self.view, alertType: .done, text: text)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.dismiss(animated: true, completion: self?.dismissVCCallback)
            }
        } else {
            let text = "Write a review text"
            self.view.endEditing(true)
            showAlert(view: self.view, alertType: .error, text: text)
        }
    }
    
    func setupKeyboadObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboardWillShow(notification: NSNotification) {
        let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        guard let keyboardAnimationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {return}
        if notification.name == UIResponder.keyboardWillShowNotification {
            reviewTextViewBottomAnchor.constant = -(keyboardFrame.height + 10)
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
            }
        } else {
            reviewTextViewBottomAnchor?.constant = -10
            UIView.animate(withDuration: keyboardAnimationDuration) {
                self.view.layoutIfNeeded()
            }
        }
    }
}
