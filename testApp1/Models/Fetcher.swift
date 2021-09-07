//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 24.08.2021.
//

import Foundation

protocol FetcherProtocol: AnyObject {
    var delegate: FetcherDelegate? { get set }
    var storer: DataStorer? { get set }
    
    // fetch from local
    func fetchFromStorage()
    // fetch from web
    func fetchFromWeb()
    
    func cancelAllRequests()
}
