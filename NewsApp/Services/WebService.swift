//
//  WebService.swift
//  NewsApp
//
//  Created by Fırat AKBULUT on 24.12.2023.
//

import Foundation

class WebService {
    
    func getArticles(url: URL, completion: @escaping (Result<[Article]?, Error>) -> Void) {
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(error))
            } else if let data = data {
                do {
                    let articleList = try JSONDecoder().decode(ArticleList.self, from: data)
                    completion(.success(articleList.articles))
                } catch {
                    print("Error decoding JSON: \(error)")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
