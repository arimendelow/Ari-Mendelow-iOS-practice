//
//  Item+CoreDataClass.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/13/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import Foundation
import CoreData


public class Item: NSManagedObject {
    
    public override func awakeFromInsert() {
        
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
