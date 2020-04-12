//
//  CoreDataLabTests.swift
//  CoreDataLabTests
//
//  Created by Cameron Rivera on 4/12/20.
//  Copyright © 2020 Cameron Rivera. All rights reserved.
//

import XCTest
@testable import CoreDataLab

class CoreDataLabTests: XCTestCase {

    func testPixModel(){
        // Arrange
        let query = "moose"
        let expectedFirstImageURL = "https://pixabay.com/get/51e0d7464e4fad0bffd8992cc62c3e7c133ed8ec4e507441732878d6964bc2_1280.jpg"
        let exp = expectation(description: "Get valid data")
        
        // Act
        PixAPI.getPhotos(query) { result in
            switch result {
            case .failure(let netError):
                XCTFail("Error fetching photos: \(netError)")
            case .success(let pictures):
                // Assert
                if let firstPicture = pictures.first{
                    exp.fulfill()
                    XCTAssertEqual(firstPicture.largeImageURL, expectedFirstImageURL)
                }
            }
        }
        wait(for: [exp], timeout: 3.0)
    }

}
