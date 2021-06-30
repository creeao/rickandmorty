//
//  MainRouter.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

class MainRouter: MainDataPassing, CharacterDetailsRoutingLogicDelegate {
    
    weak var delegate: MainRoutingLogicDelegate?
    
    // MARK: MainDataPassing
    
    weak var viewController: MainScene?
    weak var dataStore: MainDataStore?
}

extension MainRouter: MainRoutingLogic {
    func routeToCharacter() {
        guard let characterId = dataStore?.characterId else { return }

        let characterDetailsViewController = CharacterDetailsViewController()
        characterDetailsViewController.router?.delegate = self
        characterDetailsViewController.characterId = characterId
        viewController?.present(characterDetailsViewController, animated: true, completion: nil)
    }
}
