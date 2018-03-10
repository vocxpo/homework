//
//  ImaggaUploadResponse.swift
//  ImgRecoDemo
//
//  Created by dev on 2018/03/06.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

struct ImaggaUploadResponse: Codable {
    let status: String
    let uploaded: [Uploaded]
}

struct Uploaded: Codable {
    let id: String
    let filename: String
}
