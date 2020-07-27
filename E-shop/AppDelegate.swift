//
//  AppDelegate.swift
//  E-shop
//
//  Created by Vyacheslav on 29.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit
import Reachability

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var user: User?
    private var reachability : Reachability!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        
        user = Service.shared.deserializeUser()
        do {
            self.reachability = try Reachability()
            if user != nil {
                DispatchQueue.main.async { [weak self] in
                    switch self?.reachability.connection {
                    case .cellular, .wifi:
                        if self?.user != nil {
                            Service.shared.loginAccount(username: (self?.user!.username)!, password: (self?.user!.password)!) { [weak self] (reply) in
                                switch reply {
                                case .success(_):
                                    DispatchQueue.main.async {
                                        let vc = MainVC()
                                        let navController = UINavigationController(rootViewController: vc)
                                        self?.window?.rootViewController = navController
                                    }
                                    break
                                case .failure( _):
                                    DispatchQueue.main.async {
                                        let vc = LoginVC()
                                        self?.window?.rootViewController = vc
                                    }
                                    break
                                }
                            }
                        } else {
                            let vc = LoginVC()
                            self?.window?.rootViewController = vc
                        }
                        break
                    case .unavailable:
                        if self?.user != nil {
                            DispatchQueue.main.async {
                                let vc = MainVC()
                                let navController = UINavigationController(rootViewController: vc)
                                self?.window?.rootViewController = navController
                            }
                        } else {
                            let vc = LoginVC()
                            self?.window?.rootViewController = vc
                        }
                        break
                    case .none:
                        break
                    case .some(.none):
                        break
                    }
                }
            }  else {
                let vc = LoginVC()
                self.window?.rootViewController = vc
            }
        } catch {
            print(error)
        }

        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

