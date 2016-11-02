//
//  AlertPresenter.swift
//  TwitterClient
//
//  Created by Pallavi Kurhade on 10/30/16.
//  Copyright © 2016 Pallavi Kurhade. All rights reserved.
//

import UIKit

class Alert: NSObject {
    
    class func controller(error: Error?) -> UIAlertController {
        let message = error?.localizedDescription ?? "An error occurred"
        let alert = UIAlertController(title: ":/", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alert.addAction(action)
        
        return alert
    }
    
}
