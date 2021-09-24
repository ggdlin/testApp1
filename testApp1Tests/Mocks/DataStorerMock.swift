//
//  DataStorerMock.swift
//  testApp1Tests
//
//  Created by Sergey Ivanov on 20.09.2021.
//

import Foundation
import XCTest
import UIKit
@testable import testApp1

class DataStorerMock: DataStorerProtocol {
    
    var requestedForDeleteAllRecordsTimes = 0
    var requestedForLoadTimes = 0
    var loadReturnData: [ImageAndText]?
    var requestDataStorerSaveExpectation: XCTestExpectation?
    
    func save(item: ImageAndText) -> ImageAndText {
        requestDataStorerSaveExpectation?.fulfill()
        return ImageAndText(dbid: nil, image: UIImage(), text: nil)
    }
    
    func load() -> [ImageAndText]? {
        requestedForLoadTimes += 1
        return loadReturnData
    }
    
    func deleteAllRecords() {
        requestedForDeleteAllRecordsTimes += 1
    }
    
    func deleteRecord(item: ImageAndText) {
        
    }
    
    
}
