//
//  Category.swift
//  Todoey
//
//  Created by Martin Blondin on 2018-12-22.
//  Copyright © 2018 Le Studio de Technologie Éducative. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {

    @objc dynamic var name : String = ""
    let items = List<Item>()
    
    
    
}
