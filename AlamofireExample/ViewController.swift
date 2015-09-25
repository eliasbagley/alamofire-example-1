//
//  ViewController.swift
//  AlamofireExample
//
//  Created by Elias Bagley on 8/29/15.
//  Copyright (c) 2015 eliasbagley. All rights reserved.
//

import UIKit
import Alamofire
import Cartography

private let CellIdentifier = "CellIdentifier"

class MyView : UIView {
  let tableView = UITableView()

  init() {
    super.init(frame: CGRectZero)

    self.addSubview(tableView)

    setup()
    applyConstraints()
  }

  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup() {
    tableView.allowsSelection = false
    tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: CellIdentifier)
  }

  func applyConstraints() {
    constrain(tableView) {
      $0.edges == $0.superview!.edges
    }
  }

}





class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {

  var _view: MyView { return self.view as! MyView }

  var request: Request?
  var articles: [Article]? {
    didSet {
      _view.tableView.reloadData()
    }
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }

  override func loadView() {
    self.view = MyView()

    _view.tableView.delegate = self
    _view.tableView.dataSource = self

    loadData()
  }

  deinit {
    request?.cancel()
  }

  func loadData() {
    request = APIManager.sharedInstance.getArticles { [unowned self] articles in
      self.request = nil
      self.articles = articles
    }
  }

}

// MARK: UITableViewController delegate methods

extension ViewController {

  func configureCell(cell: UITableViewCell, atIndexPath indexPath: NSIndexPath) {
    if let item = getItem(indexPath) {
      cell.textLabel?.text = item.title
    }
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier(CellIdentifier) as! UITableViewCell
    self.configureCell(cell, atIndexPath: indexPath)
    return cell
  }

  func getItem(indexPath: NSIndexPath) -> Article? {
    if let articles = self.articles {
      return articles[indexPath.row]
    }

    return nil
  }
}

// MARK: UITableViewDataSource delegate methods

extension ViewController {

  func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return self.articles == nil ? 0 : self.articles!.count
  }

}

