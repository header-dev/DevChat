//
//  DataService.swift
//  DevChat
//
//  Created by kritawit bunket on 10/1/2560 BE.
//  Copyright © 2560 headerdevs. All rights reserved.
//

import Foundation
import FirebaseDatabase


class DataService {
    private static let _instance = DataService()
    
    static var instance : DataService {
        return _instance
    }
    
    var mainRef: DatabaseReference{
        return Database.database().reference()
    }

    func saveUser(uid:String) {
        
        let profile : Dictionary<String, Any> = ["firstName":"",
                                                 "lastName":""]
        mainRef.child("users").child(uid).setValue(profile)
        
    }
}
