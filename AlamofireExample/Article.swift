//
//  Article.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 8/29/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import Foundation

class Article {
  var id: Int?
  var title: String?
  var body: String?


  init(json: JSONDictionary) {
    populateWithJSON(json)
  }

  func populateWithJSON(dictionary: JSONDictionary) {
    if let id = dictionary["id"] as? Int {
      self.id = id
    }
    if let title = dictionary["title"] as? String {
      self.title = title
    }
    if let body = dictionary["body"] as? String {
      self.body = body
    }
  }

  func toJsonDictionary() -> JSONDictionary {
    var dict: JSONDictionary = [:]

    if let id = id { dict["id"] = id }
    if let title = title { dict["title"] = title }
    if let body = body { dict["body"] = body }

    return dict
  }
}
