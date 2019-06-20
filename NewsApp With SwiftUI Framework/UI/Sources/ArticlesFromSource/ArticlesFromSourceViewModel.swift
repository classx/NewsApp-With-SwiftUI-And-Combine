//
//  ArticlesFromSourceViewModel.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 20.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI
import Combine

final class ArticlesFromSourceViewModel: BindableObject {
    private let apiProvider = APIProvider()
    
    var didChange = PassthroughSubject<ArticlesFromSourceViewModel, Never>()
    
    private(set) var articles: [Article] = [] {
        didSet {
            DispatchQueue.main.async { [unowned self] in
                self.didChange.send(self)
            }
        }
    }
    
    func getArticles(from source: String) {
        guard let request = apiProvider.performArticlesFromSourceRequest(with: source) else {
            return articles = []
        }
        
        _ = apiProvider.getData(with: request)
            .decode(type: Articles.self, decoder: JSONDecoder())
            .map { $0.articles }
            .replaceError(with: [])
            .sink(receiveValue: { [weak self] (articles) in
                self?.articles = articles
            })
    }
}