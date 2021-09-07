//
//  ViewController.swift
//  testApp1
//
//  Created by Sergey Ivanov on 23.08.2021.
//

import UIKit

class ViewController: UIViewController {

    let rowsCount = 3
    var images: [ImageAndText] = []
    var fetcher: FetcherProtocol?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetcher = NetworkFetch()
        fetcher?.delegate = self
        images = arrayWithImageStubs(itemsAmount: rowsCount)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // first load images from db
        if let imagesAndTexts = fetcher?.fetchFromStorage() {
            DispatchQueue.main.async {
                self.images = imagesAndTexts
                self.tableView.reloadData()
            }
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        fetcher?.cancelAllRequests()
    }
    
    @IBAction func loadFromWebButton(_ sender: Any) {
        fetcher?.fetchFromWeb(itemsAmount: rowsCount)
        
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
        cell.imageForMe.image = cellContent.image
        cell.labelForMe.text = cellContent.text
        return cell
    }
}

extension ViewController: FetcherDelegate {
    
    
    func handlingFetchedResults(asyncReceivedItem: ImageAndText, atIndex: Int) {
        DispatchQueue.main.async { [weak self] in
            guard let count = self?.images.count, count > atIndex else { return }
            let newImage = asyncReceivedItem.image
            let newText = asyncReceivedItem.text
            print("newText: \(newText ?? "not fetched")")
            let imageAndText = ImageAndText(image: newImage, text: newText)
//            self?.storer?.save(item: imageAndText)
            self?.images[atIndex] = imageAndText
            self?.tableView.reloadRows(at: [IndexPath.init(row: atIndex, section: 0)], with: .automatic)
        }
    }
}

