//
//  TargetGen.swift
//  PerceptualHashAlgorithm
//
//  Created by closure on 7/3/14.
//  Copyright (c) 2014 closure. All rights reserved.
//

import Foundation
import CoreGraphics

func TargetGen(path: String?, f: Array<(targetPath: String) -> Bool>) -> Void {
    let filePath:NSString? = path?.stringByStandardizingPath
    let dir:NSString? = filePath?.stringByDeletingLastPathComponent
    let fileName:NSString? = filePath?.lastPathComponent.stringByDeletingPathExtension
    let fileExtension:NSString? = filePath?.pathExtension
    var idx = 0
    for fc in f {
        let tp = dir! + "/" + fileName! + "-\(++idx)." + fileExtension!
        fc(targetPath: tp)
    }
}