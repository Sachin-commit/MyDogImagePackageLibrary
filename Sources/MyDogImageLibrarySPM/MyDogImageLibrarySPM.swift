// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class DogImageLibrary {
    private var currentIndex: Int = 0
    private var dogImages = [String]()
    private var listDogImages = [String]()
    var number = 1
    private let networking: Networking
    
    public init(networking: Networking = Networking()) {
        self.networking = networking
        fetchImages(number: number) { _ in }
    }
    
    private func fetchImages(refreshList: Bool = false, number: Int, completion: @escaping (Result<[String], Error>) -> Void) {
        networking.fetchDogImages(number: number) { result in
            switch result {
            case .success(let dogImages):
                if refreshList {
                    self.listDogImages = dogImages
                    print("Making api call \(dogImages)")
                } else {
                    self.dogImages.append(contentsOf: dogImages)
                }
                completion(.success(dogImages))
            case .failure(let error):
                print("Error fetching dog images: \(error)")
                completion(.failure(error))
            }
        }
    }
    
    public func getImage(completion: @escaping (String?) -> Void) {
        if dogImages.isEmpty {
            fetchImages(number: 1) { result in
                switch result {
                case .success:
                    completion(self.dogImages.first)
                case .failure:
                    completion(nil)
                }
            }
        } else {
            completion(dogImages.first)
        }
    }
    
    public func getImages(refreshList: Bool = false, number: Int, completion: @escaping ([String]) -> Void) {
        fetchImages(refreshList: refreshList, number: number) { result in
            switch result {
            case .success(let images):
                if refreshList {
                    completion(self.listDogImages)
                } else {
                    completion(self.dogImages)
                }
            case .failure:
                completion([])
            }
        }
    }
    
    public func getNextImage(completion: @escaping (String?) -> Void) {
        if currentIndex < dogImages.count - 1 {
            currentIndex += 1
            completion(dogImages[currentIndex])
        } else {
            fetchImages(number: 1) { result in
                switch result {
                case .success:
                    self.currentIndex = self.dogImages.count - 1
                    completion(self.dogImages[self.currentIndex])
                case .failure:
                    completion(nil)
                }
            }
        }
    }
    
    public func getPreviousImage(completion: @escaping (String?) -> Void) {
        guard currentIndex > 0 else {
            completion(nil)
            return
        }
        currentIndex -= 1
        completion(dogImages[currentIndex])
    }
}
