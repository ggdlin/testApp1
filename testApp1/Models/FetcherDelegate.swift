//
//  FetcherDelegate.swift
//  testApp1
//
//  Created by Sergey Ivanov on 27.08.2021.
//

import Foundation

protocol FetcherDelegate: AnyObject {
    func handlingFetchedResults(asyncReceivedItem: ImageAndText, atIndex: Int)
}
