//
//  AppDelegate.swift
//  PerceptualHashAlgorithm
//
//  Created by closure on 7/2/14.
//  Copyright (c) 2014 closure. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet var window: NSWindow
    
    @IBOutlet var imageView : NSImageView
    
    func applicationDidFinishLaunching(aNotification: NSNotification?) {
        // Insert code here to initialize your application
        let target = "~/Desktop/1.png"
        var (hashCode, hashString) = PerceptualHashAlgorithm(contentsOfFile: target.stringByStandardizingPath).phaHash()
        println(hashCode)
        println(hashString)
        TargetGen(target, [{
            return NSImage(contentsOfFile: target.stringByStandardizingPath).grayImage().writeToFile($0.stringByStandardizingPath, atomically: true)
        }, {
            return NSImage(contentsOfFile: target.stringByStandardizingPath).scale(CGSize(width: 8, height: 8)).grayImage().writeToFile($0.stringByStandardizingPath, atomically: true)
        }])
        
    }
    
    func applicationWillTerminate(aNotification: NSNotification?) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(aNotification: NSNotification?) -> Bool {
        return true
    }
    
    
}

