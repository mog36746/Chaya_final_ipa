//
//  Item.swift
//  Chaya
//
//  Created by MI on 4/22/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import Foundation
import RealmSwift

class Item : Object {
    @objc dynamic var id = Int()
    @objc dynamic var date = String()
    @objc dynamic var title = String()
    @objc dynamic var icon = "folder"
    @objc dynamic var body = String()
    @objc dynamic var isCompleted = Bool()
}
