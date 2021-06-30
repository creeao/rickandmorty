//
//  CharacterDetailsContracts.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

// MARK: - Interactor

protocol CharacterDetailsBusinessLogic: AnyObject {
    var presenter: CharacterDetailsPresenting? { get }
    func prepareContent(request: CharacterDetails.Content.Request)
}

protocol CharacterDetailsDataStore: class {
    var characterId: Int? { get set }
}

// MARK: - Presenter

typealias CharacterDetailsPresenting = CharacterDetailsPresentationLogic & CharacterDetailsPresentationSetup

protocol CharacterDetailsPresentationLogic {
    func presentContent(response: CharacterDetails.Content.Response)
}

protocol CharacterDetailsPresentationSetup {
    func attach(viewController: CharacterDetailsDisplayLogic)
}

// MARK: - View Controller

protocol CharacterDetailsDisplayLogic: class {
    func displayContent(viewModel: CharacterDetails.Content.ViewModel)
}

// MARK: - Router

typealias CharacterDetailsRouting = (CharacterDetailsRoutingLogic & CharacterDetailsDataPassing)

protocol CharacterDetailsRoutingLogicDelegate: class {}

protocol CharacterDetailsRoutingLogic: class {
    var delegate: CharacterDetailsRoutingLogicDelegate? { get set }
}

typealias CharacterDetailsScene = (UIViewController & CharacterDetailsDisplayLogic)

protocol CharacterDetailsDataPassing: class {
    var viewController: CharacterDetailsScene? { get set }
    var dataStore: CharacterDetailsDataStore? { get set }
}
