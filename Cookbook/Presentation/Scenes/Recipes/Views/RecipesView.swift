//
//  ContentView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

struct RecipesView: View {
    // MARK: Properties
    @StateObject var viewModel: RecipesViewModel

    // MARK: Views
    var body: some View {
        VStack {
            Text("Ingredients")
            List(viewModel.ingredients) { ingredient in
                Text(ingredient.name)
            }

            Text("Recipes")
            List(viewModel.recipes) { recipe in
                Text(recipe.name)
            }
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
