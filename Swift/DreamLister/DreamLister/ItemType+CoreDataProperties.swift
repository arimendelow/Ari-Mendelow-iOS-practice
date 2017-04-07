//
//  ItemType+CoreDataProperties.swift
//  DreamLister
//
//  Created by Ari Mendelow on 3/13/17.
//  Copyright © 2017 Ari Mendelow. All rights reserved.
//

import Foundation
import CoreData


extension ItemType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ItemType> {
        return NSFetchRequest<ItemType>(entityName: "ItemType");
    }

    @NSManaged public var type: String?
    @NSManaged public var toItem: Item?

}
