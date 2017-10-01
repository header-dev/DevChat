//
//  AuthService.swift
//  DevChat
//
//  Created by kritawit bunket on 10/1/2560 BE.
//  Copyright © 2560 headerdevs. All rights reserved.
//

import Foundation
import FirebaseAuth

typealias Completion = (_ errMsg: String?,_ data: AnyObject?) -> Void

class AuthService {
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        return _instance
    }
    
    func login(email: String,password:String, onComplete: Completion?) {
        Auth.auth().signIn(withEmail: email, password: password, completion:{ (user ,error) in
            
            if error != nil {
                if let errorCode = AuthErrorCode(rawValue: error!._code){
                    switch errorCode {
                    case .userNotFound  :
                        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil{
                                self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                            }else{
                                if user?.uid != nil {
                                    //Sign In
                                    DataService.instance.saveUser(uid: user!.uid)
                                    
                                    Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil{
                                            self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                                        }else{
                                            onComplete?(nil,nil)
                                        }
                                    })
                                }
                            }
                            
                        })
                        break
                    default :
                        print(errorCode)
                    }
                }else{
                    self.handleFirebaseError(error: error! as NSError, onComplete: onComplete)
                }
            }else{
                //successfully logged in
                onComplete?(nil,user)
            }
        })
    }
    
    func handleFirebaseError(error:NSError, onComplete:Completion?) {
        print(error.localizedDescription)
        if let errorCode = AuthErrorCode(rawValue: error.code) {
            switch (errorCode){
            case .invalidEmail :
                onComplete!("Invalid email address",nil)
                break
            case .wrongPassword :
                onComplete!("Invalid password",nil)
                break
            case .emailAlreadyInUse, .accountExistsWithDifferentCredential:
                onComplete!("Could not create account. Email already in use",nil)
                break
            default:
                onComplete!("There was a problem authentication. Try again",nil)
                break
            }
        }
        
    }
    
}
