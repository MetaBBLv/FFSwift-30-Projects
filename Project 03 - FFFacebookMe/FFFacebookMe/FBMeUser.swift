//
//  FBMeUser.swift
//  FFFacebookMe
//
//  Created by zhou on 2019/6/24.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FBMeUser: NSObject {
    var name: String
    var avatarName: String
    var education: String
    
    init(name: String, avatarName: String = "bayMax", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}
