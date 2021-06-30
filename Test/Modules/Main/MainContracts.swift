//
//  MainContracts.swift
//  Test
//
//  Created by Eryk Chrustek on 29/06/2021.
//

import UIKit

// MARK: - Interactor

protocol MainBusinessLogic: AnyObject {
    var presenter: MainPresenting? { get }
    func searchCharacter(request: Main.Search.Request)
}

protocol MainDataStore: class {
    var characterId: Int? { get set }
}

// MARK: - Presenter

typealias MainPresenting = MainPresentationLogic & MainPresentationSetup

protocol MainPresentationLogic {
    func presentCharacter(response: Main.Search.Response)
}

protocol MainPresentationSetup {
    func attach(viewController: MainDisplayLogic)
}

// MARK: - View Controller

protocol MainDisplayLogic: class {
    func displayCharacter(viewModel: Main.Search.ViewModel)
}

// MARK: - Router

typealias MainRouting = (MainRoutingLogic & MainDataPassing)

protocol MainRoutingLogicDelegate: class {}

protocol MainRoutingLogic: class {
    var delegate: MainRoutingLogicDelegate? { get set }
    func routeToCharacter()
}

typealias MainScene = (UIViewController & MainDisplayLogic)

protocol MainDataPassing: class {
    var viewController: MainScene? { get set }
    var dataStore: MainDataStore? { get set }
}
