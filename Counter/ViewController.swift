//
//  ViewController.swift
//  Counter
//
//  Created by Nikola Popovic on 5/19/19.
//  Copyright © 2019 Nikola Popovic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var newTimeLabel: UILabel!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var counterTimeLabel: UILabel!
    
    let newTime = "2019-05-25T00:00:00"
    
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        newTimeLabel.text = newTime
        currentTimeLabel.text = getCurrentDateToString()
       
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(reloadViewWithDate), userInfo: nil, repeats: true)
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        
    }
    
    @objc func reloadViewWithDate() {
        
        // Days
        let days = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).0
        let hours = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).1
        let minutes = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).2
        let seconds = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).3
        counterTimeLabel.text = "\(days)d  \(hours)h  \(minutes)m  \(seconds)s"
        
        // Hours
//        let hours = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).0
//        let minutes = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).1
//        let secconds = secondsToHoursMinutesSeconds(seconds: getCounterSecconds()).2
//        counterTimeLabel.text = "\(hours)h  \(minutes)m  \(secconds)s"
    }
    
    func getCounterSecconds() -> Int {
        var counter = 0
        counter = Int(getDataFromString(dateString: newTime).timeIntervalSince1970) - Int(getDataFromString(dateString: getCurrentDateToString()).timeIntervalSince1970)
        return counter
    }
    
    func getCurrentDateToString() -> String {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        
        return formatter.string(from: Date()) // string purpose I add here
    }
    
    func secondsToHoursMinutesSeconds (seconds : Int) -> (Int, Int, Int, Int) {
        //return (seconds / 3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        return ((seconds % 31536000) / 86400, (seconds % 86400) / 3600, (seconds % 3600) / 60, seconds % 60)
    }
    
    func getDataFromString(dateString: String) -> Date {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss"
        //dateFormatter.locale = Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        let date = dateFormatter.date(from:dateString)!
        return date
    }
}

extension String {
    
    func epoch(dateFormat: String = "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK", timeZone: String? = nil) -> TimeInterval? {
        // building the formatter
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        if let timeZone = timeZone { formatter.timeZone = TimeZone(identifier: timeZone) }
        
        // extracting the epoch
        let date = formatter.date(from: self)
        return date?.timeIntervalSince1970
    }   
}
