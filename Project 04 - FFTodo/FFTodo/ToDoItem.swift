//
//  ToDoItem.swift
//  FFTodo
//
//  Created by zhou on 2019/6/25.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class ToDoItem: NSObject {

    var id: String
    var image: String
    var title: String
    var date: Date
    
    init(id: String, image: String, title: String, date: Date) {
        self.id = id
        self.image = image
        self.title = title
        self.date = date
    }
}
