//
//  ContentView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

struct DiscoverView: View {
    // MARK: Properties
    @ObservedObject var viewModel: RecipesViewModel

    // MARK: Views
    var body: some View {
        NavigationView {
            ScrollView {
                ingredientsSection
                recipesSections
            }
            .navigationTitle("Discover")
        }
        .onAppear {
            viewModel.onAppear()
        }


    }

    var ingredientsSection: some View {
        VStack(spacing: 0) {
            Text("Available ingredients")
                .foregroundColor(.blue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 0)


            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(viewModel.ingredients) { ingredient in
                        IngredientView(ingredient: ingredient)
                    }
                }
            }
        }
    }

    var recipesSections: some View {
        VStack(spacing: 0) {
            Text("Recipes")
                .foregroundColor(.blue)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .font(.title)
                .padding(.top)
                .padding(.horizontal)
                .padding(.bottom, 0)

            ForEach(viewModel.recipes) { recipe in
                RecipeView(recipe: recipe)
            }
        }
    }
}
