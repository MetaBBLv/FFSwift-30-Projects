//
//  FFArtistDetailViewController.swift
//  FFArtistry
//
//  Created by zhou on 2019/6/26.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFArtistDetailViewController: UIViewController {
    
    var selectedArtist: Artist!
    
    let moreInfoText = "Select Fro More Info >"

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = selectedArtist.name
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 300
        
        NotificationCenter.default.addObserver(forName: UIContentSizeCategory.didChangeNotification, object: .none, queue: OperationQueue.current) { [ weak self ] _ in
            self?.tableView.reloadData()
        }
    }
}

extension FFArtistDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedArtist.works.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! FFWorkTableViewCell

        let work = selectedArtist.works[indexPath.row]

        cell.workTitleLabel.text = work.title
        cell.workImageView.image = work.image

        cell.workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
        cell.workTitleLabel.textAlignment = .center
        cell.workTextView.textColor = UIColor(white: 114/255, alpha: 1)
        cell.selectionStyle = .none

        cell.workTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.workTextView.textAlignment = work.isExpanded ? .left : .center

        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        cell.workTextView.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.footnote)


        return cell
    }
}

extension FFArtistDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? FFWorkTableViewCell else {
            return
        }

        var work = selectedArtist.works[indexPath.row]

        work.isExpanded = !work.isExpanded
        selectedArtist.works[indexPath.row] = work

        cell.workTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.workTextView.textAlignment = work.isExpanded ? .left : .center

        tableView.beginUpdates()
        tableView.endUpdates()

        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

