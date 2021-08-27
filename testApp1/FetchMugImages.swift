//
//  Mug.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class FetchMugImages: Fetcher {
    weak var delegate: FetcherDelegate?
    
    func fetch(itemsAmount: Int) {
        
        for imageIndex in 0..<itemsAmount {
            DispatchQueue.global(qos: .background).async { [weak self] in
                let image = UIImage(named: "img\(imageIndex).png") ?? UIImage(systemName: "exclamationmark.shield")!
                let item = ImageAndText(image: image, text: self?.generateText())
                self?.delegate?.fetcher(asyncReceivedItem: item)
            }
            
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
