//
//  FFProductTableTableViewController.swift
//  FFGoodsAndOldPhones
//
//  Created by zhou on 2019/6/14.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFProductTableTableViewController: UITableViewController {

    private var products:[FFProduct]?
    private let identifi = "productCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        products = [
        FFProduct(name: "1907 Wall Set", cellImage: "image-cell1", fullScreenImageView: "phone-fullscreen1"),
        FFProduct(name: "1921 Dial Phone", cellImage: "image-cell2", fullScreenImageView: "phone-fullscreen2"),
        FFProduct(name: "1937 Desk Set", cellImage: "image_cell3", fullScreenImageView: "phone-fullscreen3"),
        FFProduct(name: "1984 Moto Portable", cellImage: "image_cell4", fullScreenImageView: "phone-fullscreen4")
        ]
    }
    
    // MARK: - View Transfer
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showProduct" {
//            if let cell = sender as? UITableViewCell,
//                let indexPath = tableView.indexPath(for: cell),
//                let productVC = segue.destination as? ProductViewController {
//                productVC.product = products?[indexPath.row]
//            }
//        }
//    }
//}

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showProduct" {
            if let cell = sender as? UITableViewCell,
                let indexPath = tableView.indexPath(for: cell),
                let productVC = segue.destination as? FFProductViewController {
                productVC.product = products?[indexPath.row]
            }
        }
    }
}

    // MARK: - UITableViewDataSource
extension FFProductTableTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifi, for: indexPath)
        guard let products = products else {
            return cell
        }
        cell.textLabel?.text = products[indexPath.row].name
        if let imageName = products[indexPath.row].fullScreenImageView {
            cell.imageView?.image = UIImage(named: imageName)
        }
        return cell
    }
}
