//
//  FFDetailViewController.swift
//  FFCandyScarch
//
//  Created by zhou on 2019/6/28.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFDetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var candyImageView: UIImageView!
    
    var detailCandy: FFCandy? {
        didSet {
            configureView()
        }
    }
    
    func configureView() {
        if let detailCandy = detailCandy {
            if let detailDescriptionLabel = detailDescriptionLabel, let candyImageView = candyImageView {
                detailDescriptionLabel.text = detailCandy.name
                candyImageView.image = UIImage(named: detailCandy.name)
                title = detailCandy.category
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

}
