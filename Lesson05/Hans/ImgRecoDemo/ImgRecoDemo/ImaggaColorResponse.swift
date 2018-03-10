//
//  ImaggaColorResponse.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/06.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

struct ImaggaColorResponse: Codable {
    let results: [ColorResult]
    let unsuccessful: [String]
}

struct ColorResult: Codable {
    let info: ColorInfo
    let image: String
}

struct ColorInfo: Codable {
    let background_colors: [ColorCategory]
    let image_colors: [ColorCategory]
    let foreground_colors: [ColorCategory]
}

struct ColorCategory: Codable {
    let r: String
    let g: String
    let b: String
    let percentage: Float
}
