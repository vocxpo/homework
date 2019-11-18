//
//  NewsModel.swift
//  Lesson04
//
//  Created by 呉翰 on 2019/11/17.
//  Copyright © 2019 呉翰. All rights reserved.
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
