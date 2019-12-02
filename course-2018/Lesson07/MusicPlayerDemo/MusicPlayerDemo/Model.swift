//
//  Model.swift
//  MusicPlayerDemo
//
//  Created by dev on 2018/03/18.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

struct Albums: Codable {
    let albums: [Album]
}

struct Album: Codable {
    let name: String
    let artist: String
    let publish: String
    let cover: String
    let brief: String
    let songs: [Song]
}

struct Song: Codable {
    let name: String
}
