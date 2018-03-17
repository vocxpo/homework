//
//  Model.swift
//  Imagga
//
//  Created by oopx on 2018/03/06.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

// upload
struct ImaggaUploadResponse: Codable {
    let status: String
    let uploaded: [Uploaded]
}

struct Uploaded: Codable {
    let id: String
    let filename: String
}

// tag
struct ImaggaTagResponse: Codable {
    let results: [TagConfidenceResult]
}

struct TagConfidenceResult: Codable {
    let image: String
    let tags: [Tag]
}

struct Tag: Codable {
    let confidence: Float
    let tag: String
}

// color
struct ImaggaColorResponse: Codable {
    let results: [ColorResult]
    let unsuccessful: [String]
}

struct ColorResult: Codable {
    let info: ColorInfo
    let image: String
}

struct ColorInfo: Codable {
    // let background_colors: [ColorCategory]
    let image_colors: [ColorCategory]
    // let foreground_colors: [ColorCategory]
}

struct ColorCategory: Codable {
    let r: String
    let g: String
    let b: String
    let closest_palette_color: String
    let percent: Float
}
