//
//  Model.swift
//  SimpleTranslator
//
//  Created by 呉翰 on 2019/12/01.
//  Copyright © 2019 呉翰. All rights reserved.
//

import Foundation

struct Translate: Codable {
    let from: String
    let to: String
    let trans_result: [TransResult]
}

struct TransResult: Codable {
    let src: String
    let dst: String
}

struct Error: Codable {
    let error_code: String
    let error_msg: String
}
