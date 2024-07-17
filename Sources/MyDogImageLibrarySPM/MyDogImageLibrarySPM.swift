// The Swift Programming Language
// https://docs.swift.org/swift-book
import Foundation

public class DogImageLibrary {
    private var currentIndex: Int = -1
    private var dogImages = [String]()
    
    public init() {
        Task {
            await self.loadImages()
        }
    }
    
    @MainActor
    public func loadImages() async {
        let networking = Networking()
        do {
            let dogImages = try await networking.fetchDogImages()
            self.dogImages = dogImages
        } catch {
            print("Error fetching dog images: \(error)")
        }
    }

    public func getImage() -> String? {
        if let randomImage = dogImages.randomElement() {
            return randomImage
        }
        else {
            return nil
        }
    }

    public func getImages(number: Int) -> [String] {
        let shuffledArray = dogImages.shuffled()
        return Array(shuffledArray.prefix(number))
    }

    public func getNextImage() -> String? {
        guard currentIndex + 1 < dogImages.count else { return nil }
        currentIndex += 1
        return dogImages[currentIndex]
    }

    public func getPreviousImage() -> String? {
        guard currentIndex > 0 else { return nil }
        currentIndex -= 1
        return dogImages[currentIndex]
    }
}
