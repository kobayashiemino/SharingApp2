//
//  DatabaseManeger.swift
//  SharingApp
//
//  Created by kobayashi emino on 2020/09/08.
//  Copyright © 2020 kobayashi emino. All rights reserved.
//

import FirebaseDatabase

class DatabaseManeger {
    static let shared = DatabaseManeger()
    private let database = Database.database().reference()
    
    static func safeEmail(emailAdress: String) -> String {
        var safeEmail = emailAdress.replacingOccurrences(of: ".", with: "_")
        safeEmail = safeEmail.replacingOccurrences(of: "@", with: "_")
        return safeEmail
    }
    
    // MARK: -public
    public func canCreateNewUser(email:String, username: String, completion: @escaping (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(email: String, values: [String: Any], completion: @escaping (Bool) -> Void) {
        
        database.child("users/\(email.safeDatabaseKey())").setValue(["value": values]) { (error, _) in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    
    public typealias getDataCompletion = (Result<Any, Error>) -> Void
    
    enum DatabaseManegerError: Error {
        case getDataFailed
        case postFailed
    }
    
    public func getDataFor(path: String, completion: @escaping getDataCompletion) {
        database.child("\(path)").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseManegerError.getDataFailed))
                return
            }
            completion(.success(value))
        }
    }
    
    public func userExists(with email: String, completion: @escaping ((Bool) -> Void)) {
        
    }
    
    public func postUpdate(values: [String: Any], completion: @escaping getDataCompletion) {
        
        guard let uid = AuthManeger.uid() else { return }
        
        print("valuesvalues\(values)")
        
        database.child("posts/\(uid)").childByAutoId().updateChildValues(values) {(error, ref) in
            
            guard error == nil else {
                completion(.failure(DatabaseManegerError.postFailed))
                return
            }
            completion(.success(ref))
        }
    }
    
    public func getPostData(completion: @escaping getDataCompletion) {
        
        guard let uid = AuthManeger.uid() else { return }
        
        database.child("posts/\(uid)").observeSingleEvent(of: .value, with: { (snapshot) in
            
            guard let value = snapshot.value else {
                completion(.failure(DatabaseManegerError.getDataFailed))
                return
            }
            completion(.success(value))
        })
    }
    
    public func getProfileData(email: String, completion: @escaping getDataCompletion) {
        
        database.child("users/\(email.safeDatabaseKey())").observeSingleEvent(of: .value) { (snapshot) in
            guard let value = snapshot.value else {
                completion(.failure(DatabaseManegerError.getDataFailed))
                return
            }
            
            completion(.success(value))
        }
    }
}
