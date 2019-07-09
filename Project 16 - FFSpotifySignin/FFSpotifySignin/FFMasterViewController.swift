//
//  FFMasterViewController.swift
//  FFSpotifySignin
//
//  Created by zhou on 2019/7/9.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFMasterViewController: FFVideoSplashViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupVideoBackground()
    }

    func setupVideoBackground(){
        let url = URL(fileURLWithPath: Bundle.main.path(forResource: "moments", ofType: "mp4")!)
        
        // setup layout
        videoFrame = view.frame
        fillMode = .resizeAspectFill
        alwaysRepeat = true
        sound = true
        startTime = 2.0
        alpha = 0.8
        
        contentURL = url
        view.isUserInteractionEnabled = false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
