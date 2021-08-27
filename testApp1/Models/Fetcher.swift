//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 24.08.2021.
//

import Foundation

protocol Fetcher: AnyObject {
    var delegate: FetcherDelegate? { get set }
    func fetch(itemsAmount: Int)
}
