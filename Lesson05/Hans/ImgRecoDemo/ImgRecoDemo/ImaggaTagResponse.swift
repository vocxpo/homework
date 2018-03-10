//
//  ImaggaTagResponse.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/06.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

struct ImaggaTagResponse: Codable {
    let results: [TagConfidenceResult]
}

struct TagConfidenceResult: Codable {
    let image: String
    let tags: [Tag]
}

struct Tag: Codable {
    let confidence: String
    let tag: String
}
