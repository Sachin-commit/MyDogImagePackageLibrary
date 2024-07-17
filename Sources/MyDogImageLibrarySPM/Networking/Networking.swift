//
//  File.swift
//
//
//  Created by Sachin Singla on 17/07/24.
//

import Foundation

enum NetworkError: Error {
    case invalidURL(_ error: String)
    case unexpected(_ error: String)
    case apiError(_ error: String)
    case invalidData(_ error: String)
}

final class Networking {
    
    static let sharedInstance = Networking()
    
    func fetchDogImages(count: Int) async throws -> Dog {
        let urlString = "\(Constants.API_URL)\(count)"
        guard let url = URL(string: urlString) else { throw NetworkError.invalidURL(Constants.Invalid_URL) }
        let (data, response) = try await URLSession.shared.data(from: url)
        if let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    return try decoder.decode(Dog.self, from: data)
                }
                catch {
                    throw NetworkError.invalidData(Constants.Invalid_Data)
                }
            }
            else {
                throw NetworkError.apiError("\(Constants.API_Error)\(response.statusCode)")
            }
        }
        else {
            throw NetworkError.unexpected(Constants.Unexpected_Error)
        }
    }
}
