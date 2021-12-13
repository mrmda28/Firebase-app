//
//  FirebaseManager.swift
//  Firebase-app
//
//  Created by Dmitriy Maslennikov on 04/12/2021.
//  Copyright © 2021 Dmitriy Maslennikov. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    func logInWithEmail(email: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {

        Auth.auth().signIn(withEmail: email!, password: password!) { authResult, error in
            
            if error == nil {
                completion(true, nil)
            } else {
                completion(false, (error?.localizedDescription)!)
            }
        }
    }
    
    func createUserWithEmail(email: String?, password: String?, completion: @escaping (Bool, String?) -> Void) {
        
        Auth.auth().createUser(withEmail: email!, password: password!) { authResult, error in
            
            if error == nil {
                
                Auth.auth().signIn(withEmail: email!, password: password!) { authResult, error in
                    
                    if error == nil {
                        completion(true, nil)
                    } else {
                        completion(false, (error?.localizedDescription)!)
                    }
                }
            } else {
                completion(false, (error?.localizedDescription)!)
            }
        }
    }
}
