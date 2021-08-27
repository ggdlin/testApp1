//
//  Mug.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class FetchMugImages: Fetcher {
    
    func fetch(itemsAmount: Int, for delegate: FetcherDelegate) {
        
        for imageIndex in 0..<itemsAmount {
            let image = UIImage(named: "img\(imageIndex).png") ?? UIImage(systemName: "exclamationmark.shield")!
            let item = ImageAndText(image: image, text: generateText())
            delegate.fetcher(receivedItem: item, at: imageIndex)
        }
    }
    
    private func generateText() -> String? {
        Bool.random() ? "Описание для изображения" : nil
    }
    
    init() {
        print("FetchMugImages initialised")
    }
    
    deinit {
        print("FetchMugImages DEinitialised")
    }
}
