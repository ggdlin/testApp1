//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 24.08.2021.
//

import Foundation

protocol Fetcher: AnyObject {
    func fetch(itemsCount: Int, closure: @escaping ([ImageAndText]) -> Void)
}
