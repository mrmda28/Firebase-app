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
    
    func logInWithEmail(email: String?, password: String?, completion: @escaping (Bool, String) -> Void) {
        
        guard email != "", password != "" else { return completion(false, "Email or password can't be empty.") }

        Auth.auth().signIn(withEmail: email!, password: password!) { authResult, error in
            
            if error == nil {
                completion(true, (authResult?.user.email)!)
            } else {
                completion(false, (error?.localizedDescription)!)
            }
        }
    }
}
