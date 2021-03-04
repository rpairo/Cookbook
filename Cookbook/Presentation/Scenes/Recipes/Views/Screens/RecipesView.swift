//
//  ContentView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

struct RecipesView: View {
    // MARK: Properties
    @ObservedObject var viewModel: RecipesViewModel

    // MARK: Views
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.ingredients) { ingredient in
                            IngredientView(ingredient: ingredient)
                        }
                    }
                }

                Spacer()
            }

            .navigationTitle("Recipes")
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}
