//
//  ViewController.swift
//  FFStopWath
//
//  Created by zhou on 2019/6/21.
//  Copyright © 2019 MissZhou. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate{
    

    //MARK: - varilable
    fileprivate let mainStopWath: Stopwath = Stopwath()
    fileprivate let lapStopWath: Stopwath = Stopwath()
    fileprivate var isPlay: Bool = false
    fileprivate var laps:[String] = []
    
    //MARK: - components
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var lapTimerLabel: UILabel!
    @IBOutlet weak var lapRestButton: UIButton!
    @IBOutlet weak var playPauseBtn: UIButton!
    @IBOutlet weak var lapsTableView: UITableView!
    
    //MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let initCircleButton:(UIButton) -> Void = { button in
            button.layer.cornerRadius = 0.5 * button.bounds.size.width
            button.backgroundColor = UIColor.white
        }
        
        initCircleButton(lapRestButton)
        initCircleButton(playPauseBtn)
        
        lapRestButton.isEnabled = false
        
        lapsTableView.delegate = self;
        lapsTableView.dataSource = self;
    }
    
    //MARK: - UI Setting
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return UIStatusBarStyle.lightContent
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.portrait
    }
    
    
    //MARK: - Action
    @IBAction func playPauseTimer(_ sender: Any) {
        lapRestButton.isEnabled = true
        changeButton(lapRestButton, title: "lap", titleColor: UIColor.black)
        if !isPlay {
            unowned let weakSelf = self
            mainStopWath.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateMainTimer, userInfo: nil, repeats: true)
            lapStopWath.timer = Timer.scheduledTimer(timeInterval: 0.0035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            
            RunLoop.current.add(mainStopWath.timer, forMode: RunLoop.Mode.common)
            RunLoop.current.add(lapStopWath.timer, forMode: RunLoop.Mode.common)
            
            isPlay = true
            changeButton(playPauseBtn, title: "stop", titleColor: UIColor.red)
        } else {
            mainStopWath.timer.invalidate()
            lapStopWath.timer.invalidate()
            isPlay = false
            changeButton(playPauseBtn, title: "start", titleColor: UIColor.green)
            changeButton(lapRestButton, title: "Reset", titleColor: UIColor.black)
        }
    }
    
    @IBAction func lapsResetTimer(_ sender: Any) {
        if !isPlay {
            resetMainTimer()
            resetLapTimer()
            changeButton(lapRestButton, title: "Lap", titleColor: UIColor.lightGray)
            lapRestButton.isEnabled = false
        } else {
            if let timerLabelText = timerLabel.text {
                laps.append(timerLabelText)
            }
            lapsTableView.reloadData()
            resetLapTimer()
            unowned let weakSelf = self
            lapStopWath.timer = Timer.scheduledTimer(timeInterval: 0.035, target: weakSelf, selector: Selector.updateLapTimer, userInfo: nil, repeats: true)
            RunLoop.current.add(lapStopWath.timer, forMode: RunLoop.Mode.common)
        }
    }
    
    //MARK: - private helpers
    fileprivate func changeButton(_ button: UIButton, title: String, titleColor: UIColor) {
        button.setTitle(title, for: UIControl.State())
        button.setTitleColor(titleColor, for: UIControl.State())
    }
    
    fileprivate func resetMainTimer() {
        resetTimer(mainStopWath, label: timerLabel)
        laps.removeAll()
        lapsTableView.reloadData()
    }
    
    fileprivate func resetLapTimer() {
        resetTimer(lapStopWath, label: lapTimerLabel)
    }
    
    fileprivate func resetTimer(_ stopwatch: Stopwath, label: UILabel) {
        stopwatch.timer.invalidate()
        stopwatch.counter = 0.0
        label.text = "00:00:00"
    }
    
    @objc func updateMainTimer() {
        updateTimer(mainStopWath, label: timerLabel)
    }
    
    @objc func updateLapTimer() {
        updateTimer(lapStopWath, label: lapTimerLabel)
    }
    
    func updateTimer(_ stopwatch: Stopwath, label: UILabel) {
        stopwatch.counter = stopwatch.counter + 0.035
        
        var minutes: String = "0\((Int)(stopwatch.counter / 60))"
        if (Int)(stopwatch.counter / 60) < 10 {
            minutes = "0\((Int)(stopwatch.counter / 60))"
        }
        
        var seconds: String = String(format: "%.2f", (stopwatch.counter.truncatingRemainder(dividingBy: 60)))
        if stopwatch.counter.truncatingRemainder(dividingBy: 60) < 10 {
            seconds = "0" + seconds
        }
        
        label.text = minutes + ":" + seconds
    }
}

//MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return laps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier: String = "lapCell"
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        
        if let labelNumber = cell.viewWithTag(11) as? UILabel {
            labelNumber.text = "Lap\(laps.count - (indexPath as NSIndexPath).row)"
        }
        
        if let labelTimer = cell.viewWithTag(12) as? UILabel {
            labelTimer.text = laps[laps.count - (indexPath as NSIndexPath).row - 1]
        }
        return cell
    }
}

//MARK: - Extension
fileprivate extension Selector {
    static let updateMainTimer = #selector(ViewController.updateMainTimer)
    static let updateLapTimer = #selector(ViewController.updateLapTimer)
}
