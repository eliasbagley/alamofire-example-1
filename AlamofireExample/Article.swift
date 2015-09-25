//
//  Article.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 8/29/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import Foundation

private let ID_KEY = "id"
private let TITLE_KEY = "title"
private let BODY_KEY = "body"

class Article {
  var id: Int?
  var title: String?
  var body: String?


  init(json: JSONDictionary) {
    populateWithJSON(json)
  }

  func populateWithJSON(dictionary: JSONDictionary) {
    if let id = dictionary[ID_KEY] as? Int {
      self.id = id
    }
    if let title = dictionary[TITLE_KEY] as? String {
      self.title = title
    }
    if let body = dictionary[BODY_KEY] as? String {
      self.body = body
    }
  }

  func toJsonDictionary() -> JSONDictionary {
    var dict: JSONDictionary = [:]

    if let id = id { dict[ID_KEY] = id }
    if let title = title { dict[TITLE_KEY] = title }
    if let body = body { dict[BODY_KEY] = body }

    return dict
  }
}
