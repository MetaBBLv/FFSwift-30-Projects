//
//  Helper.swift
//  FFBirthdays
//
//  Created by zhou on 2019/7/25.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import Foundation
import UIKit

class Helper {
    static func show(message:String) {
        let alertController = UIAlertController(title: "Birthdays", message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(dismissAction)
        
        let pushedViewCOntrollers = (UIApplication.shared.keyWindow?.rootViewController as! UINavigationController).viewControllers
        let presentedViewController = pushedViewCOntrollers.last
        
        presentedViewController?.present(alertController, animated: true, completion: nil)
    }
}

extension DateComponents {
    var asString : String? {
        if let date = Calendar.current.date(from: self) {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale.current
            dateFormatter.dateStyle = .medium
            let dateString = dateFormatter.string(from: date)
            
            return dateString
        }
        return nil
    }
}
