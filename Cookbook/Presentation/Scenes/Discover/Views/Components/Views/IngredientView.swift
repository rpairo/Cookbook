//
//  IngredientView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 4/3/21.
//

import SwiftUI

struct IngredientView: View {
    // MARK: Properties
    var ingredient: Ingredient

    // MARK: View
    var body: some View {
        ZStack {
            if let data = ingredient.image, let image = UIImage(data: data) {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            }

            OpaqueLayerView()
            ElementTitleView(title: ingredient.name)
        }
        .frame(width: 250, height: 150, alignment: .center)
        .background(Color(.darkGray))
        .cornerRadius(20)
        .padding(.vertical)
        .padding(.leading)
    }
}
