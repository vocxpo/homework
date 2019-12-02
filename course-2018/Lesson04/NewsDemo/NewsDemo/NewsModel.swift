//
//  NewsModel.swift
//  NewsDemo
//
//  Created by dev on 2018/02/24.
//  Copyright © 2018年 oopx. All rights reserved.
//

import Foundation

struct NewsResponse: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: ArticleSource
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
}

struct ArticleSource: Codable {
//    let id: String
    let name: String
}
