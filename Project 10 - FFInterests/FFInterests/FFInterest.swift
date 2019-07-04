//
//  FFInterest.swift
//  FFInterests
//
//  Created by zhou on 2019/7/4.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFInterest
{
    //MARK: - Public API
    var id = ""
    var title = ""
    var description = ""
    var numberOfMembers = 0
    var numberOfPosts = 0
    var featuredImage: UIImage!
    
    init(id: String, title: String, description: String, featuredImage: UIImage) {
        self.id = id
        self.title = title
        self.description = description
        self.featuredImage = featuredImage
        numberOfMembers = 1
        numberOfPosts = 1
    }
    
    //MARK: - Private
    static func createInterests() -> [FFInterest]
    {
        return [
            FFInterest(id: "r1", title: "We Love Traveling Around the World", description: "We love backpack and adventures! We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r1")!),
            FFInterest(id: "r2", title: "Romance Stories", description: "We love romantic stories. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r2")!),
            FFInterest(id: "r3", title: "iOS Dev", description: "Create beautiful apps. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r3")!),
            FFInterest(id: "r4", title: "Race", description: "Cars and aircrafts and boats and sky. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r4")!),
            FFInterest(id: "r5", title: "Personal Development", description: "Meet life with full presence. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r5")!),
            FFInterest(id: "r6", title: "Reading News", description: "Get up to date with breaking-news. We walked to Antartica yesterday, and camped with some cute pinguines, and talked about this wonderful app idea. 🐧⛺️✨", featuredImage: UIImage(named: "r6")!)
        ]
    }
}
