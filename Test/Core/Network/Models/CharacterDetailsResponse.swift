//
//  CharacterDetailsResponse.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

struct CharacterDetailsResponse: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let type: String
    let gender: String
    let origin: Location
    let location: Location
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
