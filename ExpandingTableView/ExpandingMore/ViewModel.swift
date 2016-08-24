
//
//  ViewModel.swift
//  ExpandingMore
//
//  Created by Wenhan on 7/20/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

import Foundation
import UIKit

struct MainViewModel {
    
    private let items = ItemStorage.defaultItems()
    
    func count() -> Int {
        return items.count
    }
    
    func titleForRow(row: Int) -> String {
        return items[row].title
    }
    
    func detailForRow(row: Int) -> String {
        return items[row].detail
    }
}