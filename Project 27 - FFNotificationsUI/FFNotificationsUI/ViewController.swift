//
//  ViewController.swift
//  FFNotificationsUI
//
//  Created by zhou on 2019/7/30.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func dataPickerDidSelectNoData(_ sender: UIDatePicker) {
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
            delegate.scheduleNotification(at: sender.date)
        }
    }
}

