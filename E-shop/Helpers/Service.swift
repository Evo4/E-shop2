//
//  Service.swift
//  E-shop
//
//  Created by Vyacheslav on 31.01.2020.
//  Copyright © 2020 Vyacheslav. All rights reserved.
//

import Foundation

enum ServerResult<Success, Failure>{
    case success(Success)
    case failure(Failure)
}

class Service {
    
    static let shared = Service()
    
    //MARK: - REST API methods
    fileprivate func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }

    func downloadImage(from url: URL, completion: @escaping (Data) -> ()) {
        getData(from: url) { data, response, err in
            if let error = err {
                print("Failed to download image:", error)
            } else if let data = data {
                print(response?.suggestedFilename ?? url.lastPathComponent)
                DispatchQueue.main.async {
                    completion(data)
                }
            }
        }
    }
    
    func registerAccount(username: String, password: String, completion: @escaping (ServerResult<Void, String>)->()) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/register/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["username" : username, "password" : password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
                    dict?.forEach({ (obj) in
                        if obj.key == "message" {
                            let errMessage = obj.value as! String
                            completion(.failure(errMessage))
                        } else if obj.key == "token" {
                            self.findUserID(username: username) { (userID) in
                                let token = obj.value as! String
                                let user = User(id: userID, username: username, password: password, token: token)
                                self.serializeCurrentUser(user: user)
                            }
                            completion(.success(()))
                        }
                    })
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func loginAccount(username: String, password: String, completion: @escaping (ServerResult<Void, String>)->()) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/login/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let params = ["username" : password, "password" : password]
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            print("Trying to login")
            if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any]
                    dict?.forEach({ (obj) in
                        if obj.key == "message" {
                            let errMessage = obj.value as! String
                            completion(.failure(errMessage))
                        } else if obj.key == "token" {
                            self.findUserID(username: username) { (userID) in
                                let token = obj.value as! String
                                let user = User(id: userID, username: username, password: password, token: token)
                                self.serializeCurrentUser(user: user)
                                completion(.success(()))
                            }
                        }
                    })
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func findUserID(username: String, completion: @escaping (Int)->()) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/register/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Failed to load products:", err)
            }
            if let resp = response {
                print(resp)
            }
            if let data = data {
                do {
                    print("finding user ID")
                    if let dict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions()) as? [String: Any] {
                        // search two-dimensional users dictionary
                        dict.keys.forEach({ (key) in
                            if key == "results" {
                                guard let arr: [[String:Any]] = dict[key] as? [[String : Any]] else {
                                    print("fail")
                                    return
                                }
                                //serch user id
                                arr.forEach { (pair) in
                                    if pair["username"] as! String == username {
                                        let id = pair["id"] as! Int
                                        completion(id)
                                    }
                                }
                                return
                            }
                        })
                    }
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func getProducts(completion: @escaping ([Product])->()) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/products/") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Failed to load products:", err)
            }
            if let data = data {
                do {
                    let products = try JSONDecoder().decode([Product].self, from: data)
                    completion(products)
                } catch {
                    print(error)
                }
                
            }
        }.resume()
    }
    
    func getProductReviews(productID: Int, completion: @escaping ([Review])->()) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/reviews/\(productID)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        print("product id:", productID)
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let response = response {
                print("review response:", response)
            }
            if let err = err {
                print("Failed to load review", err)
            }
            if let data = data {
                do {
                    let reviews = try JSONDecoder().decode([Review].self, from: data)
                    completion(reviews)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    
    func postReview(productID: Int, userToken: String, rate: Int, text: String) {
        guard let url = URL(string: "http://smktesting.herokuapp.com/api/reviews/\(productID)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Token \(userToken)", forHTTPHeaderField: "Authorization")
        let params = ["rate": rate, "text": text] as [String : Any]
        if JSONSerialization.isValidJSONObject(params) {
            print("JSON valid")
        }
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: params, options: []) else {return}
        request.httpBody = httpBody
        URLSession.shared.dataTask(with: request) { (data, response, err) in
            if let err = err {
                print("Failed to post review: ", err)
            }
            if let response = response {
                print("Post review response: ", response)
            }
        }.resume()
        
    }
    
    //MARK: - UserDefaults methods
    
    let defs = UserDefaults.standard
    
    func serializeCurrentUser(user: User) {
        defs.set(try? PropertyListEncoder().encode(user), forKey: "user")
    }
    
    func serializeUserToken(token: String) {
        defs.set(try? PropertyListEncoder().encode(token), forKey: "token")
    }
    
    func deserializeUser() -> User? {
        guard let data = defs.object(forKey: "user") as? Data,
            let user = try? PropertyListDecoder().decode(User.self, from: data) else {
                return nil
        }
        return user
    }
    
    func serializeSignInUser(signInUser: SignInUser) {
        defs.set(try? PropertyListEncoder().encode(signInUser), forKey: "signInUser")
    }
    
    func deserializeSignInUser() -> SignInUser? {
        guard let data = defs.object(forKey: "signInUser") as? Data,
            let signInUser = try? PropertyListDecoder().decode(SignInUser.self, from: data) else {
                return nil
        }
        return signInUser
    }
    
    func serializeIsProductsCached(isCached: Bool) {
        defs.set(isCached, forKey: "isCached")
    }
    
    func deserializeIsProductsCached() -> Bool? {
        let isCached = defs.object(forKey: "isCached") as? Bool
        return isCached
    }
    
    func serializeProducts(products: [Product]) {
        defs.set(try? PropertyListEncoder().encode(products), forKey: "products")
    }
    
    func deserializeProducts() -> [Product]? {
        guard let data = defs.object(forKey: "products") as? Data,
            let products = try? PropertyListDecoder().decode([Product].self, from: data) else {
                return nil
        }
        return products
    }
    
    func serializeReviews(reviews: [Review], productID: Int) {
        defs.set(try? PropertyListEncoder().encode(reviews), forKey: "reviews\(productID)")
    }
    
    func deserializeReviews(productID: Int) -> [Review]? {
        guard let data = defs.object(forKey: "reviews\(productID)") as? Data,
            let reviews = try? PropertyListDecoder().decode([Review].self, from: data) else {
                return nil
        }
        return reviews
    }
}
