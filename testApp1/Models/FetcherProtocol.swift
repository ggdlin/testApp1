//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 24.08.2021.
//

import Foundation

protocol FetcherProtocol: AnyObject {
    var delegate: FetcherDelegate? { get set }
    var storer: DataStorerProtocol? { get set }
    var webRequester: WebRequesterProtocol? { get set }
    
    // fetch from local
    func fetchFromStorage() -> [ImageAndText]?
    // fetch from web
    func fetchFromWeb(itemsAmount: Int)
    
    func cancelAllRequests()
    
    func deleteRecord(_ item: ImageAndText) 
}
