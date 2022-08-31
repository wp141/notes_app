//
//  SessionService.swift
//  Info1111
//
//  Created by Will Polich on 5/5/2022.
//

import Foundation
import Firebase
import FirebaseAuth

class SessionService: ObservableObject {
    
    var auth = Auth.auth()
    
    func signedIn() -> Bool  { 
        if auth.currentUser != nil {
            DispatchQueue.main.async {
                self.loggedIn = true
            }
            return true
        } else {
            DispatchQueue.main.async {
                self.loggedIn = false
            }
            return false
        }
    }
    
    @Published var loggedIn = false
    
    func register(email: String, password: String, completion: @escaping (Error?) -> ()) {
        auth.createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            
            DispatchQueue.main.async {
                self.loggedIn = true
            }
            completion(nil)
            
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Error?) -> ()) {
        auth.signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(error)
                return
            }
            DispatchQueue.main.async {
                self.loggedIn = true
            }
            print("\(String(describing: self.auth.currentUser?.uid)) signed in.")
            completion(nil)
        }
    }
    
    func logout(completion: @escaping (Error?) -> ()) {
        do {
            try auth.signOut()
            print("Successfully signed out.")
            DispatchQueue.main.async {
                self.loggedIn = false
            }
            completion(nil)
        } catch {
           completion(error)
        }
        
    }
    
}
