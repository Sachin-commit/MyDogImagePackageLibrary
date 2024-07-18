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
    
    func fetchDogImages(number: Int, completion: @escaping (Result<[String], NetworkError>) -> Void) {
        let urlString = "\(Constants.API_URL)\(number)"
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL(Constants.Invalid_URL)))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(.unexpected(Constants.Unexpected_Error)))
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unexpected(Constants.Unexpected_Error)))
                return
            }
            
            guard response.statusCode == 200, let data = data else {
                completion(.failure(.apiError("\(Constants.API_Error)\(response.statusCode)")))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let dogs = try decoder.decode(Dog.self, from: data)
                completion(.success(dogs.message))
            } catch {
                completion(.failure(.invalidData(Constants.Invalid_Data)))
            }
        }.resume()
    }
}
