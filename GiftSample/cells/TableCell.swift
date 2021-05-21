//
//  TableCell.swift
//  GiftSample
//

//

import Foundation
import UIKit

class TableCell: UITableViewCell {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var closure:((Int)->())!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
