//
//  AuthManeger.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import FirebaseAuth

class AuthManeger {
    static let shared = AuthManeger()
    
    static func uid() -> String? {
        guard let uid = Auth.auth().currentUser?.uid else { return nil }
        return uid
    }
    
    static func email() -> String? {
        guard let email = Auth.auth().currentUser?.email else { return nil}
        return email
    }
    
    private var profilePictureURL: String = ""
    
    // MARK: -public
    
    public func registerNewUser(values: [String: Any], completion: @escaping (Bool) -> Void) {
        
        guard let profilePicture = values["profilePicture"] as? Data else { return }
        guard let username = values["username"] as? String else { return }
        guard let email = values["email"] as? String else { return }
        guard let password = values["password"] as? String else { return }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .medium
        dateFormatter.locale = .current
        let date = dateFormatter.string(from: Date())
        
        let fileName = "\(username)_\(date)"
        
        StorageManeger.shared.uploadProfilePicture(with: profilePicture, fileName: fileName) { [weak self] (result) in
            
            guard let `self` = self else { return }
            
            switch result {
            case .success(let urlString):
                `self`.profilePictureURL = urlString
                
                DatabaseManeger.shared.canCreateNewUser(email: email, username: username) { (canCreate) in
                    
                    if canCreate {
                        Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                            guard error == nil, result != nil else {
                                completion(false)
                                return
                            }
                            
                            let values = ["profilePicture": `self`.profilePictureURL,
                                          "username": username,
                                          "email": email,
                                          "password": password]
                            
                            DatabaseManeger.shared.insertNewUser(email: email, values: values) { (inserted) in
                                if inserted {
                                    completion(true)
                                    return
                                } else {
                                    completion(false)
                                    return
                                }
                            }
                        }
                    } else {
                        completion(false)
                    }
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        
        if let email = email {
            
            Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                
                guard result != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
    
    public func logout(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        } catch {
            completion(false)
            return
        }
    }
}
