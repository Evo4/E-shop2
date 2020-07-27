//
//  LoginVC.swift
//  E-shop
//
//  Created by Vyacheslav on 29.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
           return .default
    }
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "logo")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var signInButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1)
        button.layer.cornerRadius = 10
        button.setTitle("Sign Up", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        button.addTarget(self, action: #selector(signInAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var signUpButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.layer.cornerRadius = 10
        button.layer.borderColor = #colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1)
        button.layer.borderWidth = 2
        button.setTitleColor(#colorLiteral(red: 0, green: 0.768627451, blue: 0.2470588235, alpha: 1), for: .normal)
        button.setTitle("Sign In", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 17)
        button.addTarget(self, action: #selector(signUpAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var guestLoginButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .clear
        button.setTitleColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.75), for: .normal)
        button.setTitle("Login as guest", for: .normal)
        button.titleLabel?.font = UIFont(name: "Raleway-Regular", size: 14)
        button.addTarget(self, action: #selector(loginAsGuestAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.signInButton, self.signUpButton, self.guestLoginButton])
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fill
        stack.spacing = 8
        return stack
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupAppearance()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func setupAppearance() {
        view.backgroundColor = #colorLiteral(red: 0.949000001, green: 0.9610000253, blue: 0.9840000272, alpha: 1)
        
    }
    
    func setupConstraints() {
        [logoImageView, stackView].forEach { (subview) in
            view.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 100),
            logoImageView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            logoImageView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            stackView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 50),
            stackView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -50),
            
            signInButton.heightAnchor.constraint(equalToConstant: 50),
            signUpButton.heightAnchor.constraint(equalToConstant: 50),
            guestLoginButton.heightAnchor.constraint(equalToConstant: 30),
        ])
    }
    
    @objc func signInAction() {
        let signInVC = SignInVC()
        presentNextVC(viewController: signInVC)
    }

    @objc func signUpAction() {
        let signUpVC = SignUpVC()
        presentNextVC(viewController: signUpVC)
    }
    
    @objc func loginAsGuestAction() {
        let mainVC = MainVC()
        let navController = UINavigationController(rootViewController: mainVC)
        presentNextVC(viewController: navController)
    }
    
    func presentNextVC(viewController: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromRight
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: false, completion: nil)
    }
}

