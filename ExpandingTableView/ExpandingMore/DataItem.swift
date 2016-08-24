//
//  DataItem.swift
//  ExpandingMore
//
//  Created by Wenhan on 7/20/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

import Foundation
import UIKit

struct ItemStorage {
    static func defaultItems() -> [SimpleItem] {
        return [
            SimpleItem(title: "Title", detail: "Title detail"),
            SimpleItem(title: "Item 1", detail: "Detail 1"),
            SimpleItem(title: "Item 2", detail: "Detail 2"),
        ]
    }
}