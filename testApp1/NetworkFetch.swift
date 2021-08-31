//
//  NetworkFetch.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class NetworkFetch: Fetcher {
    
    
    let imagePath = "https://random-d.uk/api/random?format=json"
    let textPath = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json"
    
    
    weak var delegate: FetcherDelegate?
    
    func fetch(itemsAmount: Int) {
        guard let imageJsonURL = URL(string: imagePath) else { print("Bad image url"); return }
        
        DispatchQueue.global(qos: .background).async { [weak self] in
            for requestIndex in 0..<itemsAmount {
            
                URLSession.shared.dataTask(with: imageJsonURL) { (data, _, error) in
                    if let error = error { print(error); return }
                    if let imageJsonData = data {
                        guard let parsedStringImageURL = try? JSONDecoder().decode(RandomImageJson.self, from: imageJsonData) else { return }
                        guard let imageURL = URL(string: parsedStringImageURL.url) else { return }
                        
                        let dataTask = URLSession.shared.dataTask(with: imageURL) { (data, _, error) in
                            if let error = error { print(error); return }
                            if let imageData = data, let image = UIImage(data: imageData) {
                                let text = self?.fetchQuote()
                                let item = ImageAndText(image: image, text: text)
                                print("image \(requestIndex) of \(itemsAmount) fetched")
                                self?.delegate?.handlingFetchedResults(asyncReceivedItem: item, atIndex: requestIndex)
                            }
                            
                        }
                        dataTask.resume()
                        
                    }
                }.resume()
            }
        }
    }
    
    func cancelAllRequests() {
        URLSession.shared.invalidateAndCancel()
        print("func invalidateAndCancel() executed")
    }
    

    private func fetchQuote() -> String? {
        guard let textJsonURL = URL(string: textPath) else { print("Bad text url"); return nil }
        guard let textJsonData = try? Data(contentsOf: textJsonURL) else { return nil }
        guard let parsedStringText = try? JSONDecoder().decode(RandomTextJson.self, from: textJsonData) else { return nil }
        
        return parsedStringText.quoteText
    }
    
    init() {
        print("NetworkFetch initialised")
    }
    
    deinit {
        
        print("NetworkFetch DEinitialised")
    }
}
