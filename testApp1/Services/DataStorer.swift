//
//  Storer.swift
//  testApp1
//
//  Created by Sergey Ivanov on 04.09.2021.
//

import Foundation
import UIKit
import CoreData

class DataStorer: DataStorerProtocol {
    let context: NSManagedObjectContext!
    
    init?() {
        guard let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext else { return nil }
        self.context = context
    }
    
    func load() -> [ImageAndText]? {
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            var returnedResult: [ImageAndText] = []
            for item in results {
                
                guard let imageData = item.image, let image = UIImage(data: imageData) else { return nil }
                let text = item.text
                let imageAndText = ImageAndText(dbid: item.id, image: image, text: text)
                returnedResult.append(imageAndText)
            }
            return returnedResult
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func save(item: ImageAndText) {
        
            guard let entity = NSEntityDescription.entity(forEntityName: "Record", in: context) else { return }
            guard let record =  NSManagedObject(entity: entity, insertInto: context) as? Record else { return }
            record.image = item.image.pngData()
            record.text = item.text
        
        do {
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
    }
    
    func deleteAllRecords() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Record")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try context.persistentStoreCoordinator?.execute(deleteRequest, with: context)
            try context.save()
            print("All Records deleted")
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteRecord(item: ImageAndText) {
        // TODO: fetch by ID and delete object
//        let entity = NSEntityDescription.entity(forEntityName: <#T##String#>, in: <#T##NSManagedObjectContext#>)
//        context.delete(<#T##object: NSManagedObject##NSManagedObject#>)
    }
    
    
}
