//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

@main
struct CookbookApp: App {
    // MARK: Constructor
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(.accentColor)
        ]

        UINavigationBar.appearance().titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor(.accentColor)
        ]
    }
    
    // MARK: Scenes
    var body: some Scene {
        WindowGroup {
            DiscoverView(
                viewModel: DiscoverViewModel(
                    fetchIngredientsUseCase: FetchIngredientsUseCase(
                        ingredientsRepository: IngredientsRepository(
                            ingredientsDataSource: RiMIngredientsDataSource()
                        )
                    ), fetchRecipesUseCase: FetchRecipesUseCase(
                        recipesRepository: RecipesRepository(
                            recipesDataSource: RiMRecipesDataSource()
                        )
                    ), fetchImageUseCase: FetchImageUseCase(
                        imagesRepository: ImagesRepository(
                            imagesDataSource: PixabayImagesDataSource()
                        )
                    ), filterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCase()
                )
            )
        }
    }
}
