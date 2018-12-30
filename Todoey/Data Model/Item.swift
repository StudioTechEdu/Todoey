//
//  Item.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-12-22.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object{
  @objc dynamic var title : String = ""
  @objc dynamic var done : Bool = false
  @objc dynamic var dateCreation = Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
    
}
