//
//  RecipeView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 4/3/21.
//

import SwiftUI

struct RecipeView: View {
    // MARK: Properties
    var recipe: Recipe

    // MARK: View
    var body: some View {
        ZStack {
            if let data = recipe.image, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }

            OpaqueLayerView()
            ElementTitleView(title: recipe.name)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .center)
        .frame(height: 150)
        .background(Color(.darkGray))
        .cornerRadius(20)
        .padding()
    }
}
