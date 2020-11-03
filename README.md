# Pokemon

## `Prerequisites`

If you don't have cocoapod installed in your system, open a bash terminal and then execute
```
$ sudo gem install cocoapods
```

## `Installing`

Open this folder in a bash terminal, then execute
```
$ sh install.sh
```

##  `Application info`

* Language: `Swift 5.3`
* Target: `iOS 11` SDK (ready to run also for `iOS 13 and above`)
* Runs both on iPhone and iPad, supports Portrait / Landscape
* `No trace of storyboard / xib` / framework to create views programmatically
* `Dark mode` ready
* It works also `offline`
* Some little `UnitTest` to verify that everything works fine

* Dependency manager: `CocoaPods`
My choose was between CocoaPods and Carthage, just because I've never used SwiftPackageManager yet in any project.
I choose CocoaPods because I love his centralized repository, it's really fast to learn / use and supports private code repository, even if sometimes there could be some problems on the .project file.

* External frameworks: `RxSwift`, `RxCocoa` (I know, they are one more that what was requested :) )
I choose Rx because it helps me a lot to write less, more powerful code. Once I've learned this way of programming, it's very hard to not continue that way :)



## `A Deep dive into application's design`

The application is entirely based on:

* `MVVM design pattern`
* `Dependency Injection` 
* `Protocols`


## `MVVM Pattern`

The MVVM (Model-View-ViewModel) is a design pattern with 3 differents layer: the Model, the View and the View-Model.

## `Model`

The Model layer is a collection of entities representing "real-life" objects, and additional components that can transform raw data into entities.
In the project's directory tree, we can find a directory called  "Models" , with 2 sub-directories,  "Entities" and "Repository".

### `Entities`
The "real-life" objects. 
All of them are struct object, and conforms to `ModelType` protocol (which also conforms to `Codable`).
This objects are created by calling the repository's functions with some kind of paramters as input.

### `Repository`
This directory contains 2 sub-directories:  "Repository" and "API"

#### `Repository` 
This object has a list of functions useful to provide the models to view-models.
It could retrieve data by doing http request (getting helped by the `APIManager`  object), or from the app's documents directory.
The asynchronous nature of these functions is managed by using `RxSwift` framework.

#### `Network`
The objects contained in this directory represent the network layer.
The `API` enum is a list of api to call ( just one actually)) , with useful property to build http request.
The `APIManager` contains functions capable to download raw JSON data  and decode it into model objects. 




## `View`
In the  project's directory tree, the directory called "Views" contains all the objects that rapresents the UI. 
All the view object conforms to` ViewType` and `Layoutable` protocol, and splitted into 2 files:

*`<view>View.swift` :  where the graphic components are declared, and there is  the binding between the view and his related viewModel.
*`<view>View+Layout.swift`  , where the graphic components's contraints are setted and their views are styled.

There is absolutly no business-logic in these view files:  the view's components reacts to the view-model changes.
I've used  `RxCocoa` to make binding easier.



## `ViewModel`
The View Model acts as a middle layer between the Views and the Model. It gets the entities, makes some changes on/with it and notify the view 
that it needs to react properly.
In the  project's directory tree, the directory called "ViewModesl" contains  2 sub-directories,  "ItemViewModels" and "SceneViewModels".

#### `ItemViewModels`
These object conforms to `ItemViewModelType`, and represents the viewmodel related to all the `UIView` components of the app.
They holds the data that will be binded to a particular UIView and all the informations about his style / size.
#### `SceneViewModels`

These object conforms to `SceneViewModelType`, and represents the view-model-related to all the `UIViewController` components of the app.
They reacts to user actions, gets all the data from the repository and create the list of ItemviewModels, which represents the UICollectionView.dataSource of the single view controller of the app, the `ListViewController`.



## `Dependecy injection`
I choose to use dependency injecton pattern to keep the code loosely coupled, whit the benefits of readability and testability of the code.
The `Dependency` directory of the project contains the `AppDependencyContainer` (the dependency container) 
and a collection of stateless objects conforms to `DependencyFactory` protocol,  which have methods useful to create all the component of the app.
The depedency container is a singleton, and it has a dictionary of type <String:DependencyFactory>.  
Every factory contains a link to the dependency container, so every object created can have the right and only resources he need (with the benifit of mainteinabilty)


## `Protocols`
I choose to use a protocol-oriented approach because it helps me to focus on what-the-component-should-do first, then I can implement it on a object being sure that I'm not fogot anything. That's why pretty much every component of this app conforms to some protocol. It' also achieve multiple inheritance and helps on reauseabilty of the code.


