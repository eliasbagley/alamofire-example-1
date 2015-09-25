//
//  MockServer.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 9/25/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import Foundation
import GCDWebServers
import SwiftyJSON

private let ArticleMockDataFilname = "articles"

class MockServer {

  let webServer = GCDWebServer()

  class var sharedInstance: MockServer {
      struct Singleton {
          static let instance : MockServer = MockServer()
      }
      return Singleton.instance
  }

  init() {
    webServer.addHandlerForMethod("GET", pathRegex: "/articles", requestClass: GCDWebServerRequest.self, processBlock: { request in
      let dict = self.jsonDictionaryFromFile("articles")
      return GCDWebServerDataResponse(JSONObject: dict)
    })

    webServer.startWithPort(8080, bonjourName: "Alamofire Example GCD Web Server")
  }

  var articles: JSONDictionary {
    return jsonDictionaryFromFile(ArticleMockDataFilname)
  }


  func jsonDictionaryFromFile(filename: String) -> JSONDictionary {
    let jsonString = NSBundle.stringFromFile(filename)
    let jsonData = jsonString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
    let json = JSON(data: jsonData)
    return json.dictionaryObject!
  }

  var baseUrl: String {
    return "\(webServer.serverURL)"
  }
}
