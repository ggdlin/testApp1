//
//  DataStorerProtocol.swift
//  testApp1
//
//  Created by Sergey Ivanov on 06.09.2021.
//

import Foundation


protocol DataStorerProtocol: AnyObject {
    func save(item: ImageAndText) -> ImageAndText
    func load() -> [ImageAndText]?
    func deleteAllRecords()
    func deleteRecord(item: ImageAndText)
}
