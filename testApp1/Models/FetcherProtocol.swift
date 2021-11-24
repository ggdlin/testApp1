//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 24.08.2021.
//

import Foundation

@objc
protocol FetcherProtocol: AnyObject {
    @objc    weak var delegate: FetcherDelegate? { get set }
    @objc    var storer: DataStorerProtocol? { get set }
    @objc    var webRequester: WebRequesterProtocol? { get set }
    
    // fetch from local
    @objc    func fetchFromStorage() -> [ImageAndText]?
    // fetch from web
    @objc    func fetchFromWeb(itemsAmount: Int)
    
    @objc    func cancelAllRequests()
    
    @objc   func deleteRecord(_ item: ImageAndText) 
}
