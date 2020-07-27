//
//  SceneDelegate.swift
//  E-shop
//
//  Created by Vyacheslav on 29.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import UIKit
import Reachability

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var user: User?
    private var reachability : Reachability!

    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            window = UIWindow(windowScene: windowScene)
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
                } else {
                    let vc = LoginVC()
                    self.window?.rootViewController = vc
                }
            } catch {
                print(error)
            }
        }
    }
    
    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

