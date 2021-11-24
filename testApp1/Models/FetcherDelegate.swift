//
//  FetcherDelegate.swift
//  testApp1
//
//  Created by Sergey Ivanov on 27.08.2021.
//

import Foundation

@objc
protocol FetcherDelegate: AnyObject {

    @objc    func handlingFetchedResults(asyncReceivedItem: ImageAndText, atIndex: Int)
}
