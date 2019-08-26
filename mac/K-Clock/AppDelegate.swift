//
//  AppDelegate.swift
//  K-Clock
//
//  Created by Derek Webb on 8/23/19.
//  Copyright © 2019 K-Clock. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var statusBarItem: NSStatusItem!


    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
        
        statusBarItem = NSStatusBar.system.statusItem(
            withLength: NSStatusItem.variableLength)
        statusBarItem.button?.title = "--:-- KS"
        
        let statusBarMenu = NSMenu(title: "K-Clock Menu")
        statusBarItem.menu = statusBarMenu
        
        statusBarMenu.addItem(
            withTitle: "Quit",
            action: #selector(AppDelegate.quit),
            keyEquivalent: "")
        
        // Schedule the time-update code to run ever 0.864 seconds
        Timer.scheduledTimer(withTimeInterval: 0.864, repeats: true) { (Timer) in
            // Get the current time information
            let date = Date()
            let calendar = Calendar.current
            let currentHour = calendar.component(.hour, from: date)
            let currentMinute = calendar.component(.minute, from: date)
            let currentSecond = calendar.component(.second, from: date)
            
            // Calculate the current seconds in this day (using old time standard)
            let currentHourSeconds = (currentHour * 60 * 60)
            let currentMinuteSeconds = (currentMinute * 60)
            let totalCurrentSecond = currentHourSeconds + currentMinuteSeconds + currentSecond
            
            // Calculate the kseconds in this day using the K-Clock standard
            let seconds = floor(Double(totalCurrentSecond) * 100000 / 86400)
            let kseconds = Int(floor(seconds / 1000))
            let secondsRemainder = Int(floor(seconds.truncatingRemainder(dividingBy: 1000)))
            
            // Getting rid of the last second, because on Mac there is some drift and it will sometimes look like it skips a second (ex: 65:486 -> 65:488)
            let secondsRemainderWithoutLastSecond = Int(floor(Double(secondsRemainder) / 10))
            
            // Update the button title
            self.statusBarItem.button?.title = "\(kseconds):\(secondsRemainderWithoutLastSecond) KB"
        }
    }
    
    
    @objc func quit() {
        NSApplication.shared.terminate(self)
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
