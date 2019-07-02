//
//  FFMasterTableViewCell.swift
//  FFPokedeGo
//
//  Created by zhou on 2019/7/1.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFMasterTableViewCell: UITableViewCell {

    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var pokeImageView: UIImageView!
    
    fileprivate var indicator: UIActivityIndicatorView!
    
    func awakeFromNib(_ id: Int, name: String, pokeImageUrl: String) {
        super.awakeFromNib()
        setupUI(id, name: name)
        setupNotification(pokeImageUrl)
    }
    
    deinit {
        pokeImageView .removeObserver(self, forKeyPath: "image")
    }
    
    fileprivate func setupUI(_ id: Int, name: String) {
        idLabel.text = NSString(format: "#%03d", id) as String
        nameLabel.text = name
        pokeImageView.image = UIImage(named: "default_img")
        
        indicator = UIActivityIndicatorView()
        indicator.center = CGPoint(x: pokeImageView.bounds.midX, y: pokeImageView.bounds.midY)
        indicator.style = .whiteLarge
        indicator.startAnimating()
        pokeImageView.addSubview(indicator)
        
        pokeImageView.addObserver(self, forKeyPath: "image", options: [], context: nil)
    }
    
    fileprivate func setupNotification(_ pokeImageUrl: String) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: downloadImageNotification), object: self, userInfo: ["pokeImageView":pokeImageView, "pokeImageUrl": pokeImageUrl])
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "image" {
            indicator.stopAnimating()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
