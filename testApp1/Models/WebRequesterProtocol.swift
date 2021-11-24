//
//  WebRequestProtocol.swift
//  testApp1
//
//  Created by Sergey Ivanov on 18.09.2021.
//

import Foundation

@objc
protocol WebRequesterProtocol {
    @objc    func fetchImageData(url: URL, closure: @escaping (Data?) -> Void )
    @objc    func fetchText(url: URL) -> String?
}
