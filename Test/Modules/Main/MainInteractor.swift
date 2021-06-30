//
//  MainInteractor.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

final class MainInteractor: MainDataStore {
    
    // MARK: DataStore
    
    var characterId: Int?
    
    // MARK: Properties
    
    var presenter: MainPresenting?
    var gateway: APIGateway?
}

extension MainInteractor: MainBusinessLogic {
    func searchCharacter(request: Main.Search.Request) {
        characterId = request.characterId
        presenter?.presentCharacter(response: Main.Search.Response())
    }
}
