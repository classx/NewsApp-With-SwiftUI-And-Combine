//
//  OverView.swift
//  NewsApp With SwiftUI Framework
//
//  Created by Алексей Воронов on 16.06.2019.
//  Copyright © 2019 Алексей Воронов. All rights reserved.
//

import SwiftUI

struct OverView : View {
    @State private var topHeadlines: [Article] = []
    
    private var categories: [String] = ["business", "entertainment", "general", "health", "science", "sports", "technology"]
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Top headlines".localized())
                    .font(.headline)) {
                        TopHeadlines()
                            .frame(height: 150)
                }
                
                Section(header: Text("Categories".localized())
                    .font(.headline)) {
                        ForEach(self.categories.identified(by: \.self)) { category in
                            NavigationButton(
                                destination: ArticlesFromCategory(category: category)
                                .navigationBarTitle(Text(category.localized().capitalizeFirstLetter()), displayMode: .large)
                            ) {
                                Text(category.localized().capitalizeFirstLetter())
                            }
                        }
                }
            }
            .onAppear {
                self.getCategories()
            }
            .navigationBarTitle(Text("Overview".localized()), displayMode: .large)
        }
    }
    
    private func getCategories() {
        
    }
}