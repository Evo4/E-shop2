//
//  SignUpVC.swift
//  E-shop
//
//  Created by Vyacheslav on 29.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class SignUpVC: UIViewController {

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .default
    }
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.layer.cornerRadius = 15
        view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        view.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.layer.shadowOffset = CGSize(width: 0, height: 20)
        view.layer.shadowRadius = 15
        view.layer.shadowOpacity = 0.15
        return view
    }()
    
    private lazy var backButton: BackButton = {
        let button = BackButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var headerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Raleway-Bold", size: 17)
        label.text = "Register"
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Raleway-Regular", size: 15)
        label.text = "Username"
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.font = UIFont(name: "Raleway-Regular", size: 15)
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Raleway-Regular", size: 15)
        label.text = "Password"
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.font = UIFont(name: "Raleway-Regular", size: 15)
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        label.font = UIFont(name: "Raleway-Regular", size: 15)
        label.text = "Repeat password"
        return label
    }()
    
    private lazy var repeatPasswordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textField.font = UIFont(name: "Raleway-Regular", size: 15)
        textField.borderStyle = .roundedRect
        textField.returnKeyType = .done
        return textField
    }()
    
    private lazy var enterButton: EnterButton = {
        let button = EnterButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(registerAction), for: .touchUpInside)
        return button
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
        view.addSubview(topView)
        [backButton, headerLabel, usernameLabel, usernameTextField, passwordLabel, passwordTextField, repeatPasswordLabel, repeatPasswordTextField, enterButton].forEach { (subview) in
            topView.addSubview(subview)
        }
        
        NSLayoutConstraint.activate([
            topView.topAnchor.constraint(equalTo: view.topAnchor),
            topView.leftAnchor.constraint(equalTo: view.leftAnchor),
            topView.rightAnchor.constraint(equalTo: view.rightAnchor),
            topView.heightAnchor.constraint(equalToConstant: 370),
            
            backButton.topAnchor.constraint(equalTo: topView.safeAreaLayoutGuide.topAnchor, constant: 10),
            backButton.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 15),
            
            headerLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            headerLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor),
            
            usernameLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            usernameLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),
            
            usernameTextField.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 5),
            usernameTextField.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),
            usernameTextField.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordLabel.topAnchor.constraint(equalTo: usernameTextField.bottomAnchor, constant: 10),
            passwordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 5),
            passwordTextField.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),
            passwordTextField.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            repeatPasswordLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            repeatPasswordLabel.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),

            repeatPasswordTextField.topAnchor.constraint(equalTo: repeatPasswordLabel.bottomAnchor, constant: 5),
            repeatPasswordTextField.leftAnchor.constraint(equalTo: topView.leftAnchor, constant: 20),
            repeatPasswordTextField.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20),
            repeatPasswordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            enterButton.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -15),
            enterButton.rightAnchor.constraint(equalTo: topView.rightAnchor, constant: -20)
        ])
    }
    
    @objc func backAction() {
        let transition = CATransition()
        transition.duration = 0.4
        transition.type = CATransitionType.moveIn
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        self.view.window!.layer.add(transition, forKey: kCATransition)
        
        self.dismiss(animated: false, completion: nil)
    }

    @objc func registerAction() {
        if usernameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" && repeatPasswordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != "" {
            
            if passwordTextField.text == repeatPasswordTextField.text {
                guard let username = usernameTextField.text,
                    let password = passwordTextField.text else {return}
                
                self.showIndicator(onView: self.view)
                self.view.endEditing(true)
                Service.shared.registerAccount(username: username, password: password) { [weak self] (reply) in
                    switch reply {
                    case .success():
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            let mainVC = MainVC()
                            let navController = UINavigationController(rootViewController: mainVC)
                            navController.modalPresentationStyle = .fullScreen
                            self?.present(navController, animated: true, completion: nil)
                            self?.removeIndicator()
                        }
                        break
                    case .failure(let err):
                        self?.removeIndicator()
                        DispatchQueue.main.async {
                            self?.showAlert(view: self!.view, alertType: .error, text: err)
                        }
                        break
                    }
                }
            }
        } else {
            let text = "Fill all fields to sign up"
            showAlert(view: self.view, alertType: .error, text: text)
        }
    }
}
