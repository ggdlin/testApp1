//
//  WebRequest.swift
//  testApp1
//
//  Created by Sergey Ivanov on 18.09.2021.
//

import Foundation

@objcMembers
class WebRequester: NSObject, WebRequesterProtocol {
    
    func fetchImageData(url: URL, closure: @escaping (Data?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error { print(error); return }
            if let imageJsonData = data {
                guard let parsedStringImageURL = try? JSONDecoder().decode(RandomImageJson.self, from: imageJsonData) else { return }
                guard let imageURL = URL(string: parsedStringImageURL.url) else { return }
                
                let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                    if let error = error { print(error); return }
                    
                    if let imageData = data {
                        closure(imageData)
                    }
                    
                }
                dataTask.resume()
                
            }
        }.resume()
    }
    
    
    func fetchText(url: URL) -> String? {
        
        guard let textJsonData = try? Data(contentsOf: url) else { return nil }
        guard let parsedStringText = try? JSONDecoder().decode(RandomTextJson.self, from: textJsonData) else { return nil }
        
        return parsedStringText.quoteText
    }
}
