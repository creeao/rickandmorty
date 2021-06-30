//
//  MainPresenter.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

final class MainPresenter: MainPresentationSetup {
    weak var viewController: MainDisplayLogic?
    
    func attach(viewController: MainDisplayLogic) {
        self.viewController = viewController
    }
}

extension MainPresenter: MainPresentationLogic {
    func presentCharacter(response: Main.Search.Response) {
        let viewModel = Main.Search.ViewModel()
        viewController?.displayCharacter(viewModel: viewModel)
    }
}
