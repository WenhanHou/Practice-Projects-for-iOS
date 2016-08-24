//
//  ExpandingCell.swift
//  ExpandingMore
//
//  Created by Wenhan on 7/20/16.
//  Copyright © 2016 Wenhan. All rights reserved.
//

import Foundation
import UIKit

class ExpandingCell: UITableViewCell {
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    var detail: String? {
        didSet {
            detailLabel.text = detail
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stackView.arrangedSubviews.last?.hidden = true
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        UIView.animateWithDuration(0.5,
            delay: 0,
            usingSpringWithDamping: 1,
            initialSpringVelocity: 1,
            options: UIViewAnimationOptions.CurveEaseIn,
            animations: { () -> Void in
                stackView.arrangedSubviews.last?.hidden = !selected
            },
            completion: nil)
    }

}