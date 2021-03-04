//
//  CookbookApp.swift
//  Cookbook
//
//  Created by Raúl Pera Pairó on 1/3/21.
//

import SwiftUI

@main
struct CookbookApp: App {
    // MARK: Scenes
    var body: some Scene {
        WindowGroup {
            RecipesView(
                viewModel: RecipesViewModel(
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
                    )
                )
            )
        }
    }
}
