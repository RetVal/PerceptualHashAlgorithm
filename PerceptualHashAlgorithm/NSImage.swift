//
//  NSImage.swift
//  PerceptualHashAlgorithm
//
//  Created by closure on 7/3/14.
//  Copyright (c) 2014 closure. All rights reserved.
//

import Foundation
import CoreGraphics
import AppKit

extension NSImage {
    func CGImage() -> CGImageRef {
        return self.CGImageForProposedRect(nil, context: NSGraphicsContext.currentContext(), hints: nil).takeUnretainedValue()
    }
    
    func grayImage() -> NSImage! {
        var imageRect = CGRectMake(0, 0, self.size.width, self.size.height)
        var colorSpace = CGColorSpaceCreateDeviceGray()
        var context = CGBitmapContextCreate(nil, UInt(self.size.width), UInt(self.size.height), 8, 0, colorSpace, CGBitmapInfo.fromRaw(CGImageAlphaInfo.None.toRaw())!)
        CGContextDrawImage(context, imageRect, self.CGImage())
        var imageRef = CGBitmapContextCreateImage(context)
        var newImage = NSImage(CGImage: imageRef, size: self.size)
        return newImage
    }
    
    func writeToFile(path: String!, atomically useAuxiliaryFile: Bool) -> Bool {
        return self.pngData().writeToFile(path, atomically: useAuxiliaryFile)
    }
    
    func pngData() -> NSData! {
        var rep = NSBitmapImageRep(CGImage: self.CGImage())
        var data = rep.representationUsingType(NSBitmapImageFileType.NSPNGFileType, properties: nil)
        return data
    }
    
    func scale(size: CGSize) -> NSImage! {
        var targetRect = CGRectMake(0, 0, size.width, size.height)
        var rep = self.bestRepresentationForRect(targetRect, context: nil, hints: nil)
        var image = NSImage(size: size)
        image.lockFocus()
        rep.drawInRect(targetRect)
        image.unlockFocus()
        return image
    }
}