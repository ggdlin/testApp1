//
//  FetcherDelegateMock.swift
//  testApp1Tests
//
//  Created by Sergey Ivanov on 21.09.2021.
//

import Foundation
import XCTest
@testable import testApp1

class FetcherDelegateMock: FetcherDelegate {
    
    var receiveCountExpectation: XCTestExpectation?
    
    func handlingFetchedResults(asyncReceivedItem: ImageAndText, atIndex: Int) {
        receiveCountExpectation?.fulfill()
    }
    
}
