//
//  Article.swift
//  NewsApp
//
//  Created by Fırat AKBULUT on 24.12.2023.
//

import Foundation

struct ArticleList: Decodable{
    let articles: [Article]
}

struct Article: Decodable {
    let title: String?
    let description: String?
}


