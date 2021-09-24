//
//  WebRequestProtocol.swift
//  testApp1
//
//  Created by Sergey Ivanov on 18.09.2021.
//

import Foundation

protocol WebRequesterProtocol {
    func fetchImageData(url: URL, closure: @escaping (Data?) -> Void )
    func fetchText(url: URL) -> String?
}
