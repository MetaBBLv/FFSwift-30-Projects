//
//  FFProductViewController.swift
//  FFGoodsAndOldPhones
//
//  Created by zhou on 2019/6/14.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFProductViewController: UIViewController {

    @IBOutlet weak var fullImageView: UIImageView!
    @IBOutlet weak var phoneName: UILabel!
    var product: FFProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        phoneName.text = product?.name
        if let imageName = product?.fullScreenImageView {
            fullImageView.image = UIImage(named: imageName)
        }
        
    }
    

    @IBAction func callPhone(_ sender: Any) {
        print("FFFFFFFFFFF")
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
