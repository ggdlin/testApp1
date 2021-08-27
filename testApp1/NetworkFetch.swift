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
        
        
        
        
        
        for requestIndex in 0..<itemsAmount {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let image = self?.fetchImage() ?? UIImage(systemName: "exclamationmark.shield")!
                let text = self?.fetchQuote()
                let item = ImageAndText(image: image, text: text)
                print("image \(requestIndex) of \(itemsAmount) fetched")
                self?.delegate?.fetcher(asyncReceivedItem: item)
            }
        }
    }
    
    private func fetchImage() -> UIImage? {
        
        
//        guard let imageJsonData = try? Data(contentsOf: imageJsonURL) else { return nil }

        URLSession.shared.dataTask(with: imageJsonURL) { (data, _, error) in
            guard let imageJsonData = data else { print("error: \(error?.localizedDescription ?? "unknown")"); return }
            guard let parsedStringImageURL = try? JSONDecoder().decode(RandomImageJson.self, from: imageJsonData) else { return nil }
            
        }.resume()
        
        
        guard let imageURL = URL(string: parsedStringImageURL.url) else { return nil }
        guard let imageData = try? Data(contentsOf: imageURL) else { return nil }
        guard let image = UIImage(data: imageData) else { return nil }
        
        
        return image
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
