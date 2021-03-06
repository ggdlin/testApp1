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
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        fetcher?.fetch(itemsCount: 40, closure: { [weak self] images in
            DispatchQueue.main.async {
                self?.images = images
                self?.tableView.reloadData()
            }
        })
        
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let cellContent = images[indexPath.row]
        var contentConfig = cell.defaultContentConfiguration()
        contentConfig.image = cellContent.image
        contentConfig.imageProperties.maximumSize = CGSize(width: 50, height: 50)
        contentConfig.text = cellContent.text
        cell.contentConfiguration = contentConfig
        return cell
    }
}



