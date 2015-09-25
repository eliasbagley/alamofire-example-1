//
//  APIManager.swift
//  skiracing
//
//  Created by Elias Bagley on 7/31/15.
//  Copyright (c) 2015 Rocketmade. All rights reserved.
//

import Foundation
import Alamofire

public class APIManager {

  public class var sharedInstance: APIManager {
    struct Singleton {
      static let instance : APIManager = APIManager()
    }
    return Singleton.instance
  }

  let manager = Manager()

  init() {
  }

  //MARK: methods

  func getArticles(page: Int = 1, completion: (articles: [Article]) -> ()) -> Request {
    let router = ArticleRouter(endpoint: .GetArticles(page: page))

    return manager.request(router)
      .validate()
      .responseJSON { (request, response, object, error) -> Void in
        if let error = error {
          println(error)
          return;
        }

        let articleJson = ((object as! JSONDictionary)["articles"] as? [JSONDictionary])!

        var objs: [Article] = []

        for json in articleJson {
          objs += [Article(json: json)]
        }

        completion(articles: objs)
    }
  }


}
