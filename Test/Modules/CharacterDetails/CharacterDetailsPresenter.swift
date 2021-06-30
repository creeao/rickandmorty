//
//  CharacterDetailsPresenter.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

final class CharacterDetailsPresenter: CharacterDetailsPresentationSetup {
    weak var viewController: CharacterDetailsDisplayLogic?
    
    func attach(viewController: CharacterDetailsDisplayLogic) {
        self.viewController = viewController
    }
}

extension CharacterDetailsPresenter: CharacterDetailsPresentationLogic {
    func presentContent(response: CharacterDetails.Content.Response) {
        let viewModel = CharacterDetails.Content.ViewModel(details: response.details)
        viewController?.displayContent(viewModel: viewModel)
    }
}
