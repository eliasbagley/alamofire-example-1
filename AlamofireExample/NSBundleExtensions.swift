//
//  NSBundleExtensions.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 9/25/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import Foundation

extension NSBundle {
  func stringForKey(key: String) -> String? {
    return infoDictionary?[key] as? String
  }


  class func stringFromFile(filename: String) -> String {
    let path = NSBundle.mainBundle().pathForResource(filename, ofType: "txt")
    var text = String(contentsOfFile: path!, encoding: NSUTF8StringEncoding, error: nil)!
    return text
  }
}