//
//  AppDelegate.swift
//  TwitterClient
//
//  Created by Pallavi Kurhade on 10/26/16.
//  Copyright © 2016 Pallavi Kurhade. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().barTintColor = UIColor(red:0.00, green:0.71, blue:0.80, alpha:1.0)
        
        if let user = User.currentUser {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "TweetsNavigationController")
            TwitterClient.sharedInstance?.login(user: user)
            window?.rootViewController = vc
        }
    
        NotificationCenter.default.addObserver(forName: User.userDidLogOutNotification, object: nil, queue: OperationQueue.main, using: {
            (Notification) -> () in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            
            self.window?.rootViewController = vc
        })
        
        return true
    }
    
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        
        TwitterClient.sharedInstance?.handleOpenUrl(url)
        return true
    }


}

