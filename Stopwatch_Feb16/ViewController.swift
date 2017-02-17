//
//  ViewController.swift
//  Stopwatch_Feb16
//
//  Created by Upadhyay, Priyanka on 2/16/17.
//  Copyright © 2017 Upadhyay, Priyanka. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var laps: [String] = []
    
    var timer = Timer()
    var minutes: Int = 0
    var seconds: Int = 0
    var fractions: Int = 0
    var stopwatchString: String = ""
    var startStopWatch: Bool = true
    var addLap: Bool = false
    

    @IBOutlet weak var stopwatchLabel: UILabel!
    
    @IBOutlet weak var lapsTableView: UITableView!
    
    @IBOutlet weak var startStopButton: UIButton!
    
    @IBOutlet weak var lapResetButton: UIButton!
    
    @IBAction func startStop(_ sender: Any) {
        
        if startStopWatch == true {
            
            timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: Selector(("updateStopwatch")), userInfo: nil, repeats: true)
            startStopWatch = false
            
            startStopButton.setImage(UIImage(named: "stop.png"), for: UIControlState.normal)
            
            lapResetButton.setImage(UIImage(named: "lap.png"), for: UIControlState.normal)
            addLap = true
            }
        
        else {
            timer.invalidate()
            startStopWatch = true
            
            startStopButton.setImage(UIImage(named: "start.png"), for: UIControlState.normal)
            
            lapResetButton.setImage(UIImage(named: "reset.png"), for: UIControlState.normal)
            
            addLap = false
            }
    }
    
        
    @IBAction func lapReset(_ sender: Any) {
        
        if addLap == true {
            
            laps.insert(stopwatchString, at: 0)
            lapsTableView.reloadData()
            
        }
        
        else {
            
            addLap = false
            lapResetButton.setImage(UIImage(named:"lap.png"), for: .normal)
            fractions = 0
            seconds = 0
            minutes = 0
            
            stopwatchString = "00:00:00"
            stopwatchLabel.text = stopwatchString
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        stopwatchLabel.text = "00:00:00"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

func updateStopWatch() {
    fractions += 1
    if fractions == 100 {
        
        seconds += 1
        fractions = 0
        
    }
    
    if seconds == 60 {
        minutes += 1
        seconds = 0
    }
    
    let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
    
    let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    
    let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
 
    
    stopwatchString = "\(minutesString):\(secondsString):\(fractionsString)"
    stopwatchLabel.text = stopwatchString
    
    }

    //Table View Methods
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.backgroundColor = self.view.backgroundColor
        cell.textLabel?.text = "Lap \(indexPath.row)"
        cell.detailTextLabel?.text = laps[indexPath.row]
        
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return laps.count
    }

}


