//
//  FFAboutUSViewController.swift
//  FFGoodsAndOldPhones
//
//  Created by zhou on 2019/6/14.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFAboutUSViewController: UIViewController {

    @IBOutlet var scroll: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(self.scroll)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if #available(iOS 11.0, *) {
            self.scroll.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.frame.width, height: view.frame.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
        } else {
            self.scroll.frame = CGRect(x: 0, y: topLayoutGuide.length, width: view.frame.width, height: view.frame.height - topLayoutGuide.length - bottomLayoutGuide.length)
        }
        self.scroll.contentSize = CGSize(width: view.frame.width, height: 679)
    }
}
