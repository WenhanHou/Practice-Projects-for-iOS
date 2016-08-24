//
//  ViewController.swift
//  ExpandingMore
//
//  Created by Wenhan on 7/20/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

//
//  MainViewController.swift
//  ExpandingStackCells
//
//  Created by József Vesza on 27/06/15.
//  Copyright © 2015 Jozsef Vesza. All rights reserved.
//

import UIKit

let expandingCellId = "expandingCell"
let height: CGFloat = 150
let topInset: CGFloat = 20

class MainViewController: UITableViewController {
    
    let viewModel = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = topInset
        tableView.estimatedRowHeight = height
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    // tableView DataSource
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.count()
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("expandingCell", forIndexPath: indexPath) as! ExpandingCell
        
        cell.title = viewModel.titleForRow(indexPath.row)
        cell.detail = viewModel.detailForRow(indexPath.row)
        
        return cell
    }
    
    // tableView delegate
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        
        if let selectedIndex = tableView.indexPathForSelectedRow where selectedIndex == indexPath {
            
            tableView.beginUpdates()
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
            tableView.endUpdates()
            
            return nil
        }
        
        return indexPath
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

