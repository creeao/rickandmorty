//
//  CharacterDetailsModels.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

enum CharacterDetails {
    enum Content {
        struct Request {
            let characterId: Int
        }
        
        struct Response {
            let details: Details?
        }
        
        struct ViewModel {
            let details: Details?
        }
    }
}
