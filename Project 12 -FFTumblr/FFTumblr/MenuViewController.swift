//
//  MenuViewController.swift
//  FFTumblr
//
//  Created by zhou on 2019/7/8.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    var transitionManager = TransitionManager()
    

    @IBOutlet weak var textPostIcon: UIImageView!
    @IBOutlet weak var textPostLabel: UILabel!
    
    @IBOutlet weak var photoPostIcon: UIImageView!
    @IBOutlet weak var photoPostLabel: UILabel!
    
    @IBOutlet weak var quotePostIcon: UIImageView!
    @IBOutlet weak var quotePostLabel: UILabel!
    
    @IBOutlet weak var linkPostIcon: UIImageView!
    @IBOutlet weak var linkPostLabel: UILabel!
    
    @IBOutlet weak var chatPostIcon: UIImageView!
    @IBOutlet weak var chatPostLabel: UILabel!
    
    @IBOutlet weak var audioPostIcon: UIImageView!
    @IBOutlet weak var audioPostLabel: UILabel!
    
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.transitioningDelegate = self.transitionManager
    }
    
    @IBAction func cancelBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
