//
//  Fetcher.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//


import UIKit

class Fetcher: NSObject, FetcherProtocol {
    
    let imagePath = "https://random-d.uk/api/random?format=json"
    let textPath = "https://api.forismatic.com/api/1.0/?method=getQuote&format=json"
    var storer: DataStorerProtocol?
    var webRequester: WebRequesterProtocol?
    
    weak var delegate: FetcherDelegate?
    
    func fetchFromStorage() -> [ImageAndText]? {
        storer?.load()
    }
    
    func fetchFromWeb(itemsAmount: Int) {
        // очищаем хранилище
        storer?.deleteAllRecords()
        // загружаем из веба, поштучно передаем делегату и сохраняем в хранилище
        guard let imageJsonURL = URL(string: imagePath) else { print("Bad image url"); return }
        
        DispatchQueue.global(qos: .utility).async { [weak self] in

            for requestIndex in 0..<itemsAmount {
                
                self?.webRequester?.fetchImageData(url: imageJsonURL) { (data) in
                    if let imageData = data, let image = UIImage(data: imageData) {
                        
                        var text: String? {
                            if let textPath = self?.textPath, let textUrl = URL(string: textPath) {
                                let text = self?.webRequester?.fetchText(url: textUrl)
                                return text
                            }
                            return nil
                        }
                        
                        
                        var item = ImageAndText(image: image, text: text)
                        print("image fetched, index:\(requestIndex) of amount:\(itemsAmount)")
                        if let storedItem = self?.storer?.save(item: item) {
                            item = storedItem
                        }
                        self?.delegate?.handlingFetchedResults(asyncReceivedItem: item, atIndex: requestIndex)
                    }
                    
                }
                
                
            }
        }
    }
    

  
    
    func cancelAllRequests() {
        URLSession.shared.invalidateAndCancel()
        print("func invalidateAndCancel() executed")
    }
    
    func deleteRecord(_ item: ImageAndText) {
        storer?.deleteRecord(item: item)
    }
    
}
