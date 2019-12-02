//
//  TodoModel.swift
//  TodoDemo
//
//  Created by 呉翰 on 2019/11/17.
//  Copyright © 2019 呉翰. All rights reserved.
//

import Foundation

struct Todo: Codable {
    let completed: Bool
    let date: String
    let location: String
    let task: String
}
