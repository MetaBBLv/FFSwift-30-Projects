//
//  Stopwath.swift
//  FFStopWath
//
//  Created by zhou on 2019/6/21.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class Stopwath: NSObject {

    var counter: Double
    var timer: Timer
    
    override init() {
        counter = 0.00
        timer = Timer()
    }
    
}
