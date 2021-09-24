//
//  WebRequesterMock.swift
//  testApp1Tests
//
//  Created by Sergey Ivanov on 20.09.2021.
//

import Foundation
import XCTest
@testable import testApp1

class WebRequesterMock: WebRequesterProtocol {
    
    var fetchImageDataRequestCountExpectation: XCTestExpectation?
    var fetchTextRequestCountexpectation: XCTestExpectation?
    var imageDataToFetch: Data?
    
    
    func fetchImageData(url: URL, closure: @escaping (Data?) -> Void) {
        closure(imageDataToFetch)
        fetchImageDataRequestCountExpectation?.fulfill()
    }
    
    func fetchText(url: URL) -> String? {
        fetchTextRequestCountexpectation?.fulfill()
        return nil
    }
    
    
}
