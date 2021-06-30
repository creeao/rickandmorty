//
//  GatewayInstance.swift
//  Test
//
//  Created by Eryk Chrustek on 30/06/2021.
//

import Foundation

class GatewayInstance: NSObject, APIGateway {

    // MARK: - Initialization
    
    public required override init() {
        super.init()
    }

    // MARK: - Public
    
    func makeRequest<T: Decodable>(model: T.Type, url: String, success: @escaping (T) -> Void, failure: @escaping () -> Void)  {
        guard let url = URL(string: url) else {
            print("Invalid URL")
            return
        }
        
        URLSession.shared.dataTask(with: URLRequest(url: url)) { data, response, error in
            if let data = data {
                do {
                    let decoder = try JSONResponse<T>().response(for: data)
                    DispatchQueue.main.async {
                        success(decoder)
                        return
                    }
                } catch {
                    failure()
                }
            }
            print("Fetch failed: \(error?.localizedDescription ?? "Unknown error")")
        }
        .resume()
    }
}
