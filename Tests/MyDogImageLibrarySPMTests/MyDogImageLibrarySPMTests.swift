import XCTest
@testable import MyDogImageLibrarySPM

final class MyDogImageLibrarySPMTests: XCTestCase {
    
    var dogImageLibrary: DogImageLibrary!
    var mockNetworking: MockNetworking!
    
    override func setUp() {
        super.setUp()
        mockNetworking = MockNetworking()
        dogImageLibrary = DogImageLibrary(networking: mockNetworking)
    }

    override func tearDown() {
        dogImageLibrary = nil
        mockNetworking = nil
        super.tearDown()
    }
    
    func testFetchImagesSuccess() {
        let expectation = self.expectation(description: "Fetch images success")
        
        dogImageLibrary.getImages(refreshList: true, number: 2) { images in
            XCTAssertEqual(images.count, 2, "Images count should be 2")
            XCTAssertEqual(images, self.mockNetworking.mockImages, "Images should match mock images")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testFetchImagesFailure() {
        mockNetworking.shouldReturnError = true
        let expectation = self.expectation(description: "Fetch images failure")
        
        dogImageLibrary.getImages(number: 2) { images in
            XCTAssertTrue(images.isEmpty, "Images should be empty on failure")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetImageWhenEmpty() {
        let expectation = self.expectation(description: "Get image when empty")
        
        dogImageLibrary.getImage { image in
            XCTAssertNotNil(image, "Image should not be nil")
            XCTAssertEqual(image, self.mockNetworking.mockImages.first, "Image should match mock image")
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetNextImage() {
        let expectation = self.expectation(description: "Get next image")
        
        dogImageLibrary.getImages(number: 2) { _ in
            self.dogImageLibrary.getNextImage { image in
                XCTAssertEqual(image, self.mockNetworking.mockImages.last, "Next image should match second mock image")
                expectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testGetPreviousImage() {
        let expectation = self.expectation(description: "Get previous image")
        
        dogImageLibrary.getImages(number: 2) { _ in
            self.dogImageLibrary.getNextImage { _ in
                self.dogImageLibrary.getPreviousImage { image in
                    XCTAssertEqual(image, self.mockNetworking.mockImages.first, "Previous image should match first mock image")
                    expectation.fulfill()
                }
            }
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
}
