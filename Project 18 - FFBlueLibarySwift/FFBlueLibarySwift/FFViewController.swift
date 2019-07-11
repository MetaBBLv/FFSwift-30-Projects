//
//  FFViewController.swift
//  FFBlueLibarySwift
//
//  Created by zhou on 2019/7/10.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class FFViewController: UIViewController {

    // MARK: - IBOutlet
    @IBOutlet weak var dataTable: UITableView!
    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var scroller: FFHorizontalScrollerView!
    
    // MARK: - Private Vaiables
    fileprivate var allAlums = [FFAlbum]()
    fileprivate var currentAlbumData: [AlbumData]?
    fileprivate var currentAlbumIndex = 0
    // use a stack to push and pop operation for the undo option
    fileprivate var undoStack: [(FFAlbum, Int)] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        func setUI() {
            navigationController?.navigationBar.isTranslucent = false
        }
        
        func setData() {
            currentAlbumIndex = 0
            allAlums = FFLibaryAPI.sharedInstance.getAlbums()
        }
        
        func setComponents() {
            dataTable.backgroundView = nil
            loadPreviousState()
            scroller.delegate = self
            scroller.dataSource = self
            reloadScroller()
            scroller.scrollToView(at: currentAlbumIndex)
            
            let undoButton = UIBarButtonItem(barButtonSystemItem: .undo, target: self, action: Selector.undoActin)
            undoButton.isEnabled = false
            let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
            let trashButton = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: .deleteAlbum)
            let toolbarbuttonItems = [undoButton, space, trashButton]
            toolBar.setItems(toolbarbuttonItems, animated: true)
        }
        setUI()
        setData()
        setComponents()
        showDataForAlbum(at: currentAlbumIndex)
        
        NotificationCenter.default.addObserver(self, selector: Selector.saveCurrentState, name: UIApplication.didEnterBackgroundNotification, object: nil)
    }
    
    func showDataForAlbum(at index: Int) {
        if index < allAlums.count && index > -1 {
            let album = allAlums[index]
            currentAlbumData = album.tableRepresentation
        } else {
            currentAlbumData = nil
        }
        
        dataTable.reloadData()
    }
    
    // MARK: - Memento pattern
    @objc func saveCurrentState() {
        // when The user leaves the app and then comes  back again, he wants it to be in the exact same state
        // he left it. in order to do this we need to save the currently displayed album.
        // since it's only one piece of information we can use NSUserDefaluts
        UserDefaults.standard.set(currentAlbumIndex, forKey: Constants.indexRestorationKey)
        FFLibaryAPI.sharedInstance.saveAlbums()
    }
    
    func loadPreviousState() {
        currentAlbumIndex = UserDefaults.standard.integer(forKey: Constants.indexRestorationKey)
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    // MARK: - Scroller Related
    func reloadScroller() {
        allAlums = FFLibaryAPI.sharedInstance.getAlbums()
        if currentAlbumIndex < 0 {
            currentAlbumIndex = 0
        } else if currentAlbumIndex >= allAlums.count {
            currentAlbumIndex = allAlums.count - 1
        }
        scroller.reload()
        showDataForAlbum(at: currentAlbumIndex)
    }
    
    func addAlbumAtIndex(_ album: FFAlbum, index: Int) {
        FFLibaryAPI.sharedInstance.addAlbum(album, index: index)
        currentAlbumIndex = index
        reloadScroller()
    }
    
    @objc func deleteAlbum() {
        // get album
        let deleteAlbum: FFAlbum = allAlums[currentAlbumIndex]
        // add to stack
        let undoAction = (deleteAlbum, currentAlbumIndex)
        undoStack.insert(undoAction, at: 0)
        // user libary API to delete the album
        FFLibaryAPI.sharedInstance.deleteAlbum(currentAlbumIndex)
        reloadScroller()
        // enable the undo button
        let barbuttonItems = toolBar.items! as [UIBarButtonItem]
        let undoButton : UIBarButtonItem = barbuttonItems[0]
        undoButton.isEnabled = true
        
        //disable trashButton when no albums left
        if (allAlums.count == 0) {
            let trashButton: UIBarButtonItem = barbuttonItems[2]
            trashButton.isEnabled = false
        }
    }
    
    @objc func undoAction() {
        let barButtonItems = toolBar.items! as [UIBarButtonItem]
        //pop to undo the last one
        if undoStack.count > 0 {
            let (deleteAlbum, index) = undoStack.remove(at: 0)
            addAlbumAtIndex(deleteAlbum, index: index)
        }
        // disable undo button when no albums left
        if undoStack.count == 0 {
            let undoButton: UIBarButtonItem = barButtonItems[0]
            undoButton.isEnabled = false
        }
        // enable the trashButton as there must be at least one album there
        let trashButton: UIBarButtonItem = barButtonItems[2]
        trashButton.isEnabled = true
    }
}

// MARK: - UItableViewDataSource
extension FFViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let albumData = currentAlbumData {
            return albumData.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellIdentifier, for: indexPath)
        
        if let albumData = currentAlbumData {
            cell.textLabel?.text = albumData[(indexPath as NSIndexPath).row].title
            cell.detailTextLabel?.text = albumData[(indexPath as NSIndexPath).row].value
        }
        return cell
    }
}

// MARK: - HorizontalScrollDataSource
extension FFViewController: HorizontalScrollerDataSource {
    func numberOfViews(in horizontalScrollerView: FFHorizontalScrollerView) -> Int {
        return allAlums.count
    }
    
    func horizontalScrollerView(_ horizontalScrollerView: FFHorizontalScrollerView, viewAt index: Int) -> UIView {
        let album = allAlums[index]
        
        let albumView = FFAlbumView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), coverUrl: album.coverUrl)
        
        if currentAlbumIndex == index {
            albumView.heightAlbum(true)
        } else {
            albumView.heightAlbum(false)
        }
        
        return albumView
    }
}

// MARK: - HorizontalScrollerDelegate
extension FFViewController: HorizontalScrollerDelegate {
    func horizontalScrollerView(_ horizontalScrollerView: FFHorizontalScrollerView, didselectViewAt index: Int) {
        let previousAlbumView = scroller.viewAtIndex(currentAlbumIndex) as! FFAlbumView
        previousAlbumView.heightAlbum(false)
        currentAlbumIndex = index
        let albumview = scroller.viewAtIndex(currentAlbumIndex) as! FFAlbumView
        albumview.heightAlbum(true)
        
        showDataForAlbum(at: currentAlbumIndex)
        
    }
}

// MARK: - Constants
fileprivate enum Constants {
    static let cellIdentifier = "Cell"
    static let indexRestorationKey = "currentAlbumIndex"
}

fileprivate extension Selector {
    static let undoActin = #selector(FFViewController.undoAction)
    static let deleteAlbum = #selector(FFViewController.deleteAlbum)
    static let saveCurrentState = #selector(FFViewController.saveCurrentState)
}

