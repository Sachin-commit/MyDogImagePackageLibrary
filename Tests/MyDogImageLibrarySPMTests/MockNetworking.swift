//
//  File.swift
//  
//
//  Created by Sachin Singla on 18/07/24.
//

import Foundation
@testable import MyDogImageLibrarySPM

class MockNetworking: Networking {
    
    var shouldReturnError = false
    var mockImages: [String] = [
        "https://images.dog.ceo/breeds/pyrenees/n02111500_4687.jpg",
        "https://images.dog.ceo/breeds/terrier-bedlington/n02093647_2335.jpg"
    ]
    var mockError: NetworkError = .unexpected(Constants.Unexpected_Error)
    
    override func fetchDogImages(number: Int, completion: @escaping (Result<[String], NetworkError>) -> Void) {
        if shouldReturnError {
            completion(.failure(mockError))
        } else {
            completion(.success(mockImages))
        }
    }
}

