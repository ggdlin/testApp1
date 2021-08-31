//
//  ViewController.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class ViewController: UIViewController {
    var images: [ImageAndText] = []
    var fetcher: Fetcher?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher = NetworkFetch()
        fetcher?.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let rowsCount = 3
        images = arrayWithImageStubs(itemsAmount: rowsCount)
        fetcher?.fetch(itemsAmount: rowsCount)
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetcher?.cancelAllRequests()
    }
    
    private func arrayWithImageStubs(itemsAmount: Int) -> [ImageAndText] {
        let image = UIImage(systemName: "hourglass") ?? UIImage()
        return Array(repeating: ImageAndText(image: image), count: itemsAmount)
    }
    
    deinit {
        print("Table ViewController DEinitialized")
    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        images.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let cellContent = images[indexPath.row]
//        var contentConfig = cell.defaultContentConfiguration()
//        contentConfig.image = cellContent.image
//        contentConfig.imageProperties.maximumSize = CGSize(width: 50, height: 50)
//        contentConfig.text = cellContent.text
//        cell.contentConfiguration = contentConfig
        
        cell.imageForMe.image = cellContent.image
        cell.textFieldForMe.text = cellContent.text
        return cell
    }
}

extension ViewController: FetcherDelegate {
    func handlingFetchedResults(asyncReceivedItem: ImageAndText, atIndex: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let count = self?.images.count, count > atIndex, atIndex < self?.tableView.numberOfRows(inSection: 0) ?? 0 else { return }
            let newImage = asyncReceivedItem.image
            let newText = asyncReceivedItem.text
            print("newText: \(newText ?? "not fetched")")
            self?.images[atIndex] = ImageAndText(image: newImage, text: newText)
            self?.tableView.reloadRows(at: [IndexPath.init(row: atIndex, section: 0)], with: .automatic)
        }
    }
}

