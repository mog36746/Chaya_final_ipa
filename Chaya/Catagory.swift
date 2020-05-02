//
//  Catagory.swift
//  Chaya
//
//  Created by MI on 4/17/20.
//  Copyright © 2020 Mog. All rights reserved.
//

import Foundation
import RealmSwift

class Catagory : Object{
    @objc dynamic var id = Int()
    @objc dynamic var name = String()    
    let tasks = List<Task>()
}
