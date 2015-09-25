//
//  ViewController.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 8/29/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

  var request: Request?

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    loadData()
  }

  deinit {
    request?.cancel()
  }

  func loadData() {
    request = APIManager.sharedInstance.getArticles { [unowned self] articles in
      self.request = nil
      println("received articles: \(articles)")
    }

  }


}

