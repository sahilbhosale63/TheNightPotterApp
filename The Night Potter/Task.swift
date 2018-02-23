//
//  Task.swift
//  The Night Potter
//
//  Created by Sahil Bhosale on 22/02/18.
//  Copyright © 2018 Sahil Bhosale. All rights reserved.
//

import Foundation

enum TaskType{
    case daily, weekly, monthly
}

struct Task {
    var name : String
    var type : TaskType
    var completed : Bool
    var lastCompleted : NSData?
}
