//
//  ArticleRouter.swift
//  skiracing
//
//  Created by Elias Bagley on 7/31/15.
//  Copyright (c) 2015 Rocketmade. All rights reserved.
//

import Foundation
import Alamofire

enum ArticleEndpoint {
  case GetArticles(page: Int)
  case GetArticle(id: Int)
  case UpdateArticle(article: Article)
  case DeleteArticle(id: Int)
}

class ArticleRouter : BaseRouter {

  var endpoint: ArticleEndpoint
  init(endpoint: ArticleEndpoint) {
    self.endpoint = endpoint
  }

  override var method: Alamofire.Method {
    switch endpoint {
    case .GetArticles: return .GET
    case .GetArticle: return .GET
    case .UpdateArticle: return .PUT
    case .DeleteArticle: return .DELETE
    }
  }

  override var path: String {
    switch endpoint {
    case .GetArticles: return "articles.json"
    case .GetArticle(let id): return "/\(id)/article.json"
    case .UpdateArticle(let article): return "/\(article.id)/article.json"
    case .DeleteArticle(let id): return "/\(id)/article.json"
    }
  }

  override var parameters: APIParams {
    switch endpoint {
    case .GetArticles(let page):
      return ["page" : page]

    case .UpdateArticle(let article):
      return article.toJsonDictionary()

    default: return nil
    }
  }

  override var encoding: Alamofire.ParameterEncoding? {
    switch endpoint {
    case .GetArticles: return .URL
    case .GetArticle: return .URL
    default: return .JSON
    }
  }
  
}
