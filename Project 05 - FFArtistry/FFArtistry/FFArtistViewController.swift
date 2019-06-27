//
//  FFArtistViewController.swift
//  FFArtistry
//
//  Created by zhou on 2019/6/26.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFArtistViewController: UIViewController {
    
    let artists = Artist.artistsFromBundle()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 140
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.current) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FFArtistDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow {
                destination.selectedArtist = artists[indexPath.row]
        }
    }
}

extension FFArtistViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return artists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FFCell", for: indexPath) as! FFArtistTableViewCell
        let artist = artists[indexPath.row]
        
        cell.bioLabel.text = artist.bio
        cell.bioLabel.textColor = UIColor(white: 114/255, alpha: 1)
        cell.artistImageView.image = artist.image
        cell.nameLabel.text = artist.name
        cell.nameLabel.backgroundColor = UIColor(red: 1, green: 152/255, blue: 0, alpha: 1)
        cell.nameLabel.textColor = UIColor.white
        cell.nameLabel.textAlignment = .center
        cell.selectionStyle = .none
        
        cell.nameLabel.font = UIFont.preferredFont(forTextStyle: .headline)
        cell.bioLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        return cell
    }
}
