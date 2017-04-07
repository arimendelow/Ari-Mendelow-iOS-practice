//
//  ItemCell.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/13/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import UIKit

class ItemCell: UITableViewCell {

    @IBOutlet weak var thumb: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!
    @IBOutlet weak var details: UILabel!
    
    func configureCell(item: Item) {
        
        title.text = item.title //set title text to item title (held in attributes of item entity)
        price.text = "$\(item.price)"
        details.text = item.details
        thumb.image = item.toImage?.image as? UIImage //this is here to update icon to selected image
        
    }

}
