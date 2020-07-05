//
//  TransformerCell.swift
//  Transformer
//
//  Created by Hoang Tran on 2020-07-04.
//  Copyright © 2020 Hoang Tran. All rights reserved.
//

import Foundation
import UIKit

protocol TransformerTableCellDelegate:class {
    func didSelectEditButton(_ indexPath : IndexPath) -> Void
}

class TransformerTableCell : UITableViewCell{
    
    static let CELL_HEIGHT : CGFloat = 100

    weak var delegate:TransformerTableCellDelegate?
    var currentIndexPath : IndexPath?
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var propertiesLabel: UILabel!
    @IBOutlet weak var valuesLabel: UILabel!
    @IBOutlet weak var editButton: UIButton!
    
    @IBAction func editButtonClick(_ sender: Any) {
        self.delegate?.didSelectEditButton(self.currentIndexPath ?? IndexPath())
    }
    
    
}

