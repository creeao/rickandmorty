//
//  APIGateway.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

protocol APIGateway: class {
    func makeRequest<T: Decodable>(model: T.Type, url: String, success: @escaping (T) -> Void, failure: @escaping () -> Void)
}
