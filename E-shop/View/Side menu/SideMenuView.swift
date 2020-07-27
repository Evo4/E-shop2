//
//  SideMenuView.swift
//  E-shop
//
//  Created by Vyacheslav on 31.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit

class SideMenuView: UIView {

    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = #imageLiteral(resourceName: "logo").withRenderingMode(.alwaysTemplate)
        imageView.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        imageView.backgroundColor = .clear
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.35)
        return view
    }()
    
    lazy var menuTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return tableView
    }()
    
    var callback: ((UIViewController)->())?
    var menuItems:[MenuItem] = []
    
    var isSignIn: Bool? {
        didSet {
            guard let isSignIn = self.isSignIn else {return}
            switch isSignIn {
            case true:
                self.menuItems = [
                    MenuItem(name: "Settings", image: #imageLiteral(resourceName: "settings")),
                    MenuItem(name: "Logout", image: #imageLiteral(resourceName: "exit"))
                ]
                break
            case false:
                self.menuItems = [
                    MenuItem(name: "Logout", image: #imageLiteral(resourceName: "exit"))
                ]
                break
            }
            self.menuTableView.reloadData()
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
        self.backgroundColor = #colorLiteral(red: 0, green: 0.7689999938, blue: 0.2469999939, alpha: 1)
        menuTableView.register(SideMenuCell.self, forCellReuseIdentifier: "cell")
        menuTableView.delegate = self
        menuTableView.dataSource = self
    }
    
    func setupConstraints() {
        [logoImageView, menuTableView, separatorView].forEach { (subview) in
            self.addSubview(subview)
        }
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: self.topAnchor),
            logoImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            logoImageView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            logoImageView.heightAnchor.constraint(equalToConstant: 150),
            
            menuTableView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            menuTableView.leftAnchor.constraint(equalTo: self.leftAnchor),
            menuTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            menuTableView.rightAnchor.constraint(equalTo: self.rightAnchor),
            
            separatorView.topAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            separatorView.widthAnchor.constraint(equalTo: self.widthAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
        ])
    }
}

extension SideMenuView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SideMenuCell {
            let item = menuItems[indexPath.row]
            cell.menuItem = item
            cell.callback = {
                self.cellAction(by: indexPath.row)
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func cellAction(by row: Int) {
        if menuItems.count > 1 {
            switch row {
            case 0:
                callback?(SettingsVC())
                break
            case 1:
                Service.shared.defs.removeObject(forKey: "user")
                Service.shared.defs.removeObject(forKey: "signInUser")
                Service.shared.defs.removeObject(forKey: "isCached")
                callback?(LoginVC())
                break
            default:
                break
            }
        } else {
            Service.shared.defs.removeObject(forKey: "user")
            Service.shared.defs.removeObject(forKey: "signInUser")
            Service.shared.defs.removeObject(forKey: "isCached")
            callback?(LoginVC())
        }
    }
}
