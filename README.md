# Cookbook

![Icon](https://user-images.githubusercontent.com/14141324/110068149-5d022780-7d75-11eb-917d-c6c558633a67.png)

This application is a portfolio to meet the challenge of a selection process.

In my implementation I have used [SwiftUI](https://developer.apple.com/xcode/swiftui/) as a visual library. The reason is simple: it is the future of design in the Apple ecosystem. I have also decided to use the [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) provided by the system, due to its integration with the idiosyncrasy of iOS.

I have also built on the concepts of [Clean Architecture](https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html) along with the [MVVM](https://en.wikipedia.org/wiki/Model–view–viewmodel) visual pattern. The reason for using this combination is in the maintainability, scalability and decoupling they provide.

As for the design, I have modified this one to comply with [Apple's Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/). I realized that the design presented in the requirements was done as a fast MVP, without taking into account the idiosyncrasies of the platform.

Due to the simplicity of the view, I have not seen it necessary to implement a ViewRouter or a Dependency Injector.

I have also implemented [SwiftLint](https://github.com/realm/SwiftLint) with [Ray Wenderlich's ](https://github.com/raywenderlich/swift-style-guide)setting as a linter. This is a tool to enforce Swift style and conventions.

## Scenes

I have grouped the views into different scenes, depending on the context of the flow of the set. Each View has a corresponding ViewModel, that is in charge of all the logical management of the view, freeing it from such responsibility, and I have undocked any reusable components.

### Discover

|Discover|
|---|
|![Discover](https://user-images.githubusercontent.com/14141324/110064194-ef51fd80-7d6c-11eb-96c6-f0dfe052d63e.png)|


## Architecture

For the development of the architecture I have used concepts from Clean Architecture and SOLID. Making use of these to improve the maintainability of the project and providing a robust base from which to scale. Separating the project into 3 main layers.

I have used dependency inversion to be able to provide versatility and decoupling to the code. In this way, through the injection of dependencies we obtain many facilities when testing and mocking the dependencies of the SUT. It also provides us with the versatility of being able to switch between logic modules that comply with the protocols and, in this way, have the possibility of exchanging certain behaviors without affecting the rest of the project. All this, complying with the principle of segregation.

|Project structure|Presentation structure|Domain structure|Data structure|Application structure|
|---|---|---|---|---|
|![Project](https://user-images.githubusercontent.com/14141324/110061144-58367700-7d67-11eb-8bcb-48e53e6039f9.png)|![Presentation](https://user-images.githubusercontent.com/14141324/110062482-9c2a7b80-7d69-11eb-8261-e2292e9f6658.png)|![Domain](https://user-images.githubusercontent.com/14141324/110061480-f32f5100-7d67-11eb-9dfa-5aaf8b5a57fe.png)|![Data](https://user-images.githubusercontent.com/14141324/110061698-50c39d80-7d68-11eb-9831-ccb72763be73.png)|![Application](https://user-images.githubusercontent.com/14141324/110061791-76e93d80-7d68-11eb-8b64-7c762b8f0eea.png)|


### Presentation layer

In the presentation layer there are two main characters: the Views and the ViewModels.

Views are a declarative representation based on state, decoupled from logic, as this will be handled by the viewmodels.

We are going to analyze an example of View and ViewModel.

#### View

```swift
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
```

First of all, you can see the import of the ViewModel and its respective **PropertyWrappers** to provide the necessary logic in the performance of this view.

It should be emphasized that the view should not have any responsibility for any logic, and should only be limited to displaying the user interface.

We can observe a clear modularization of the views used in the composition of the main view, thus facilitating its maintainability and readability.

In case of finding repetitions of view, it must be encapsulated as an independent view for reuse, complying with the **DRY** principle.

All logic derived from user interactions or received events will be managed through the ViewModel, delegating the computation to it and receiving a possible result that changes the state of the view.

In this case there are many magic numbers and strings, derived from the time available for the development of this technical test. In a real production case, this data should be centralized and localized in the case of strings, out of sight.

#### ViewModel

```swift
class DiscoverViewModel: ObservableObject {
    // MARK: Properties
    @Published var ingredients = [Ingredient]()
    @Published var recipes = [Recipe]()

    // MARK: Use cases
    var fetchIngredientsUseCase: FetchIngredientsUseCaseable
    var fetchRecipesUseCase: FetchRecipesUseCaseable
    var fetchImageUseCase: FetchImageUseCaseable
    var filterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable

    // MARK: Constructor
    init(fetchIngredientsUseCase: FetchIngredientsUseCaseable,
         fetchRecipesUseCase: FetchRecipesUseCaseable,
         fetchImageUseCase: FetchImageUseCase,
         filterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable) {

        self.fetchIngredientsUseCase = fetchIngredientsUseCase
        self.fetchRecipesUseCase = fetchRecipesUseCase
        self.fetchImageUseCase = fetchImageUseCase
        self.filterRecipesByIngredientsUseCase = filterRecipesByIngredientsUseCase
    }

    // MARK: Lifecycle
    func onAppear() {
        self.fetchIngredients {
            self.fetchIngredientsImages()

            self.fetchRecipes {
                self.fetchRecipesImages()
            }
        }
    }
}

// MARK: Events
extension DiscoverViewModel {
    func settingsTapped() {
        print("Config button tapped")
    }
}
```
First of all, we can see the exposed properties using the PropertyWrapper **@Published** to feed them with the inputs from the view.

The ViewModels have declared the use cases that they will require to fulfill their functionality.

In this case, we have the **FetchIngredientsUseCaseable**, which is responsible for obtaining ingredients, and the **FilterRecipesByIngredientsUseCaseable**, which is responsible for filter recipes availables.

I communicate with the use cases through Closures and Result types. I have chosen this method for its elegance and clarity.

Through the use of extensions, we divide the functional contexts of the ViewModel to facilitate its maintainability.

It is important to keep the ViewModel decoupled from the view, avoiding any dependency and/or import of visual libraries. Communication between the viewmodel and the view will occur through the observables.

### Domain layer

The domain layer is totally foreign to the rest of the layers, and it is strictly forbidden to know anything outside of it. Nor should the platform import libraries, recommending only using the language API and nothing else. In this way, we can reuse this layer if we wanted to in any other project, regardless of the version of the operating system or the visual language used, on any platform that supports the language.

This layer is responsible for providing through the **Use Cases** what is requested. If necessary, they will need **repositories** to obtain the necessary data with which to fulfill their function.

Communication with the repositories will be done through a protocol, thus abstracting itself from the data layer.

#### UseCase protocol

```swift
import Foundation

//MARK: Use case errors
enum FetchRecipesError: Error {
    case url
    case decoding
    case emptyList
    case unkown(Error)
}

//MARK: Use case result
typealias FetchRecipesResult = (Result<[Recipe], FetchRecipesError>) -> Void

protocol FetchRecipesUseCaseable {
    // MARK: Functionality
    func execute(onComplete: @escaping FetchRecipesResult)
}
```

The use case protocol is the element that decouples the presentation layer from the domain. This will be in charge of communicating both layers. For convenience, I like to take advantage of the file of the declaration of this protocol to also declare the type of result that the use case is going to offer, and if necessary, a type of error of its own for it.

#### UseCase

```swift
import Foundation

struct FilterRecipesByIngredientsUseCase: FilterRecipesByIngredientsUseCaseable {
    // MARK: Functionality
    func execute(recipes: [Recipe], ingredients: [Ingredient]) -> [Recipe] {
        recipes.filter { recipe in
            thereIs(this: recipe.ingredients, in: ingredients)
        }
    }

    func thereIs(this recipe: [Ingredient], in ingredients: [Ingredient]) -> Bool {
        for ingredient in recipe {
            guard ingredients.contains(where: { $0.name == ingredient.name }) else {
                return false
            }
        }

        return true
    }
}
```

The use case is the element in charge of managing the logic necessary to construct the response that the presentation layer has requested. It can contain other use cases and repositories as dependencies to obtain the resources required for its function.

#### Repository protocol

```swift
import Foundation

protocol ImagesRepositable {
    // MARK: Fcuntionality
    func fetch(name: String, onComplete: @escaping FetchImageResult)
}
```

Repository protocols are the elements in charge of decoupling the obtaining of data from the domain. They are used to maintain an abstract communication between the use case and the repository.

The protocol must bring together the operations that belong to the same context.

#### Entity

```swift
import Foundation

struct Recipe: Identifiable {
    // MARK: Properties
    var id: UUID
    var name: String
    var image: Data?
    var ingredients: [Ingredient]
}
```

The entity is nothing more than a flat model without logic, to transmit data between the different layers of the architecture. The domain layer is completely foreign to the presentation and data layers, so the latter will communicate with the domain using their own entities.

### Data layer

In the data layer we find two main actors: The Repositories and the DataSources.

The repository is foreign to the implementation of the data source, so the latter must communicate with the repository with entities known to it.

#### Repository

```swift
import Foundation

struct IngredientsRepository: IngredientsRepositable {
    // MARK: Data sources
    var ingredientsDataSource: IngredientsDataSourceable

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchIngredientsResult) {
        ingredientsDataSource.fetch(onComplete: onComplete)
    }
}
```

The repositories are in charge of managing all the operations of the same context, and choosing a suitable data source for it. It could be the case of using different data sources for the same repository, that is why there is a data source corresponding to each operation.

#### DataSource protocol
```swift
import Foundation

protocol RecipesDataSourceable {
    // MARK: Functionality
    func fetch(onComplete: @escaping FetchRecipesResult)
}
```

The data sources must implement the communication protocol with the repository, thus decoupling any dependencies between them.

#### DataSource

```swift
import Foundation

extension RiMIngredientsDataSource {
    // MARK: Properties
    var fetchUrl: URL? {
        guard let endpoint = configuration?.endpoint(.ingredients) else { return nil }
        guard let url = URL(string: endpoint) else { return nil }
        return url
    }

    // MARK: Functionality
    func fetch(onComplete: @escaping FetchIngredientsResult) {
        let session = URLSession(configuration: .default)
        guard let url = fetchUrl else {
            onComplete(.failure(.url))
            return
        }

        session.dataTask(with: url) { data, result, error in
            if let error = error {
                onComplete(.failure(.unkown(error)))
            }

            guard let ingredients = self.decodeIngredients(data) else {
                onComplete(.failure(.decoding))
                return
            }

            guard !ingredients.ingredients.isEmpty else {
                onComplete(.failure(.emptyList))
                return
            }

            onComplete(.success(ingredients.transform()))
        }
        .resume()
    }
}

// MARK: Transformations
extension RiMIngredientsDataSource {
    func decodeIngredients(_ data: Data?) -> IngredientsDTO? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        guard let ingredients = try? decoder.decode(IngredientsDTO.self, from: data) else { return nil }
        return ingredients
    }
}
```

The data sources is the element in charge of obtaining the data. It can be both remote data (http for example) or local data (from third party libraries for example).

This layer is allowed to import external elements if necessary, since they will be encapsulated in it, and will not affect the rest of the architecture.

#### DTO's

```swift
struct RecipesDTO: Decodable {
    // MARK: Properties
    var recipes: [RecipeDTO]

    // MARK: Constructor
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        recipes = try container.decode([RecipeDTO].self)
    }

    // MARK: Functionality
    func transform() -> [Recipe] {
        recipes.map { recipe in
            recipe.transform()
        }
    }
}
```

For the sake of cleanliness and readability, I like to extend the external models and implement transformation responsibility between the domain entity (BO) and it (DTO). Or create my own DTO entities with which to manipulate the external data collection, and later propagate it to the architecture.

To do this, I create a function that transforms the DTO into BO, mapping the local properties and calling the DTO's constructor with them.
