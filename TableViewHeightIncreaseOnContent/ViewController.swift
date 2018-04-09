//
//  ViewController.swift
//  TableViewHeightIncreaseOnContent
//
//  Created by Rishab Dutta on 09/04/18.
//  Copyright © 2018 Rishab Dutta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    
    let CellId = "MyTableViewCell"
    var indexPath: IndexPath?
    var cellHeight: CGFloat!
    let defaultCellHeight: CGFloat = 44.0

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.estimatedRowHeight = 44.0
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: CellId, bundle: nil), forCellReuseIdentifier: CellId)
    }
    
    private var addCellSubviews: (() -> ())!
    
    private lazy var changeCellHeightCompletion: (IndexPath, CGFloat) -> () = { [unowned self] (iPath: IndexPath, heightToBeAdded: CGFloat) in
        self.indexPath = iPath
        self.cellHeight = self.defaultCellHeight + heightToBeAdded
        UIView.beginAnimations("aaa", context: nil)
        UIView.setAnimationDuration(1)
        self.tableView.beginUpdates()
        self.tableView.reloadRows(at: [iPath], with: .none)
        self.tableView.endUpdates()
        UIView.commitAnimations()
        if heightToBeAdded > 0.0 {
            self.addCellSubviews()
        }
//        self.tableView.layoutIfNeeded()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId, for: indexPath) as! MyTableViewCell
        cell.backgroundColor = indexPath.row % 2 == 0 ? .red : .blue
        cell.indexPath = indexPath
        cell.changeCellHeightCompletion = changeCellHeightCompletion
        addCellSubviews = cell.addCellSubviews
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let iPath = self.indexPath else { return UITableViewAutomaticDimension }
        if indexPath == iPath {
            return cellHeight
        }
        else {
            return UITableViewAutomaticDimension
        }
    }
    
}

