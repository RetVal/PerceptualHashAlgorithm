//
//  PerceptualHashAlgorithm.swift
//  PerceptualHashAlgorithm
//
//  Created by closure on 7/3/14.
//  Copyright (c) 2014 closure. All rights reserved.
//

import Foundation
import CoreGraphics
import AppKit

class PerceptualHashAlgorithm : NSObject {
    var image:NSImage!
    init() {
        image = nil
        super.init()
    }
    
    init(image:NSImage!) {
        self.image = image.scale(CGSize(width: 8, height: 8)).grayImage()
        super.init()
    }
    
    init(contentsOfFile path:NSString!) {
        self.image = NSImage(contentsOfFile: path).scale(CGSize(width: 8, height: 8)).grayImage()
        super.init()
    }
    
    class func hamdist(x: UInt64, y: UInt64) -> Int {
        var dist:Int = 0
        var val = x ^ y
        while val != 0 {
            ++dist
            val &= val - 1
        }
        return dist
    }
    
    func phaHash() -> (UInt64, String) {
        let w = Int(image.size.width)
        let h = Int(image.size.height)
        var rep = NSBitmapImageRep(CGImage: image.CGImage())
        var bitmapData = rep.bitmapData
        var sum = 0
        
        for i in 0..64 {
            sum += Int(bitmapData[i])
        }
        var avg = sum / 64
        var ret:Character[] = Array<Character>(count: 64, repeatedValue: "0")
        var retNum: UInt64 = 0
        for i in 0..64 {
            if Int(bitmapData[63 - i]) >= avg {
                ret[i] = "1"
                retNum |= 1 << UInt64(63 - i)
            } else {
                ret[i] = "0"
                retNum |= 0 << UInt64(63 - i)
            }
        }
        var str = ""
        for c in ret {
            str += c
        }
        return (retNum, str)
    }
}
