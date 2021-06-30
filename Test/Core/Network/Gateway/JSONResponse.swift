//
//  JSONResponse.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

struct JSONResponse<Response: Decodable>: APIResponse {
    typealias ResponseType = Response

    func response(for data: Data) throws -> ResponseType {
        let decoder = JSONDecoder()
        return try decoder.decode(ResponseType.self, from: data)
    }
}
