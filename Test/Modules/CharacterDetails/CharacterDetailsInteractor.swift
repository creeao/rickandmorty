//
//  CharacterDetailsInteractor.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

final class CharacterDetailsInteractor: CharacterDetailsDataStore {
    
    // MARK: DataStore
    
    var characterId: Int?
    
    // MARK: Properties
    
    var presenter: CharacterDetailsPresenting?
    var gateway: APIGateway?
}

extension CharacterDetailsInteractor: CharacterDetailsBusinessLogic {
    func prepareContent(request: CharacterDetails.Content.Request) {
        gateway?.makeRequest(
            model: CharacterDetailsResponse.self,
            url: AppStaticConfig.url + String(request.characterId),
            success: { response in
                guard let data = response as? CharacterDetailsResponse else { return }
                let response = CharacterDetails.Content.Response(
                    details: Details(
                        name: data.name,
                        gender: data.gender,
                        avatar: data.image,
                        episodeList: String(data.episode.count)))
                self.presenter?.presentContent(response: response)
        },
            failure: {
                self.presenter?.presentContent(response: CharacterDetails.Content.Response(details: nil))
        })
    }
}
