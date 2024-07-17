// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class DogImageLibrary {
    private var images: [String] = []
    private var currentIndex: Int = -1
    
    public init() {
            Task {
                do {
                    let dogImages = try await Networking.sharedInstance.fetchDogImages(count: 10)
                    self.images = dogImages.message
                } catch {
                    print("Error fetching dog images: \(error)")
                }
            }
        }

    public func getImage() -> String? {
        return images.first
    }

    public func getImages(number: Int) -> [String] {
        return Array(images.prefix(number))
    }

    public func getNextImage() -> String? {
        guard currentIndex + 1 < images.count else { return nil }
        currentIndex += 1
        return images[currentIndex]
    }

    public func getPreviousImage() -> String? {
        guard currentIndex > 0 else { return nil }
        currentIndex -= 1
        return images[currentIndex]
    }
}
