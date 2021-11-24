//
//  DataStorerProtocol.swift
//  testApp1
//
//  Created by Sergey Ivanov on 06.09.2021.
//

import Foundation

@objc
protocol DataStorerProtocol: AnyObject {
    @objc   func save(item: ImageAndText) -> ImageAndText
    @objc    func load() -> [ImageAndText]?
    @objc    func deleteAllRecords()
    @objc   func deleteRecord(item: ImageAndText)
}
