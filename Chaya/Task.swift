//
//  Task.swift
//  Chaya
//
//  Created by MI on 4/17/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import Foundation
import RealmSwift

class Task : Object {
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var icon = "folder"
    let catagory = LinkingObjects(fromType: Catagory.self, property: "tasks")
}
