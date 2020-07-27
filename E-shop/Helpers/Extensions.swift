//
//  Extensions.swift
//  E-shop
//
//  Created by Vyacheslav on 04.02.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import Foundation
import UIKit

var accessoryView : UIView?

extension UIViewController {
    func showIndicator(onView : UIView) {
        let indicatorView = UIView.init(frame: onView.bounds)
        indicatorView.backgroundColor = #colorLiteral(red: 0.5, green: 0.5019607843, blue: 0.5019607843, alpha: 0.5)
        let activityIndicator = UIActivityIndicatorView.init(style: .whiteLarge)
        activityIndicator.startAnimating()
        activityIndicator.center = indicatorView.center
        
        DispatchQueue.main.async {
            indicatorView.addSubview(activityIndicator)
            onView.addSubview(indicatorView)
        }
        
        accessoryView = indicatorView
    }
    
    func removeIndicator() {
        DispatchQueue.main.async {
            accessoryView?.removeFromSuperview()
            accessoryView = nil
        }
    }
    
    
    func setupAlertView(onView : UIView, alertType: AlertType, text: String) {
        let alertView = AlertView(frame: CGRect(x: 0, y: 0, width: 200, height: 200))
        alertView.center = onView.center
        alertView.alertType = alertType
        alertView.alertLabel.text = text
        DispatchQueue.main.async {
            onView.addSubview(alertView)
        }
        
        accessoryView = alertView
    }
    
    func removeAlertView() {
        DispatchQueue.main.async {
            accessoryView?.removeFromSuperview()
            accessoryView = nil
        }
    }
    
    func showAlert(view: UIView, alertType: AlertType, text: String) {
        UIView.animate(withDuration: 0.5) {
            DispatchQueue.main.async { [weak self] in
                self?.setupAlertView(onView: view, alertType: alertType, text: text)
            }
        }
        UIView.animate(withDuration: 0.5) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) { [weak self] in
                self?.removeAlertView()
            }
        }
    }
}

extension UITextField {
    func bottomLineBorder() {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: self.bottomAnchor),
            view.leftAnchor.constraint(equalTo: self.leftAnchor),
            view.rightAnchor.constraint(equalTo: self.rightAnchor),
            view.heightAnchor.constraint(equalToConstant: 1)
        ])
    }
}
