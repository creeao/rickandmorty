//
//  APIResponse.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

protocol APIResponse {
    associatedtype ResponseType
    func response(for data: Data) throws -> ResponseType
}
