//
//  ContentView.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

struct DiscoverView: View {
    // MARK: Properties
    @StateObject var viewModel: DiscoverViewModel

    // MARK: Views
    var body: some View {
        NavigationView {
            ScrollView(showsIndicators: false) {
                ingredientsSection
                recipesSections
            }

            .navigationTitle("Discover")
            .navigationBarItems(trailing: ProfileSettingsButton {
                viewModel.settingsTapped()
            })
        }
        .onAppear {
            viewModel.onAppear()
        }
    }
}

// MARK: Sections
extension DiscoverView {
    var ingredientsSection: some View {
        VStack(spacing: 0) {
            SectionTitleView(title: "Available ingredients")

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
            SectionTitleView(title: "Recipes")

            ForEach(viewModel.recipes) { recipe in
                RecipeView(recipe: recipe)
            }
        }
    }
}
