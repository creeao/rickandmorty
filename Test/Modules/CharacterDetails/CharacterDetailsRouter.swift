//
//  CharacterDetailsRouter.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import UIKit

class CharacterDetailsRouter: CharacterDetailsDataPassing {
    
    weak var delegate: CharacterDetailsRoutingLogicDelegate?
    
    // MARK: CharacterDetailsDataPassing
    
    weak var viewController: CharacterDetailsScene?
    weak var dataStore: CharacterDetailsDataStore?
}

extension CharacterDetailsRouter: CharacterDetailsRoutingLogic {
}
