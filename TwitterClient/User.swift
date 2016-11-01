//
//  User.swift
//  TwitterClient
//
//  Created by Pallavi Kurhade on 10/27/16.
//  Copyright © 2016 Pallavi Kurhade. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class User: NSObject {
    static let userDidLogOutNotification = Notification.Name("UserDidLogOut")

    var id: Int?
    var name: String?
    var screenName: String?
    var tagLine: String?
    var profileUrl: URL?
    var dictionary: NSDictionary?
    var requestToken: BDBOAuth1Credential?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        
        id = dictionary["id"] as? Int
        name = dictionary["name"] as? String
        screenName = dictionary["screen_name"] as? String
        tagLine = dictionary["description"] as? String
        let profileUrlString = dictionary["profile_image_url_https"] as? String
        if let profileUrlString = profileUrlString {
            profileUrl = URL(string: profileUrlString)
        }
    }
    
    private static var _currentUser: User?
    class var currentUser: User? {
        get {
            guard _currentUser == nil else { return _currentUser }
            
            let defaults = UserDefaults.standard
            let userData = defaults.object(forKey: "currentUserData") as? Data
            
            if let userData = userData {
                let dictionary = try? JSONSerialization.jsonObject(with: userData, options: []) as! NSDictionary
                guard let dict = dictionary else { return nil }
                
                _currentUser = User(dictionary: dict)
            }
            
            return _currentUser
        } set(user) {
            let defaults = UserDefaults.standard
            if let user = user {
                let data = try! JSONSerialization.data(withJSONObject: user.dictionary!, options: [])
                
                defaults.set(data, forKey: "currentUserData")
            } else {
                defaults.set(nil, forKey: "currentUserData")
            }
            
            defaults.synchronize()
        }
    }
}
