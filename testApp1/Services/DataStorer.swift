//
//  Storer.swift
//  testApp1
//
//  Created by Sergey Ivanov on 04.09.2021.
//

import Foundation
import UIKit
import CoreData

@objc
@objcMembers
class DataStorer: NSObject, DataStorerProtocol {
    let context: NSManagedObjectContext!
    
    override init() {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            self.context = context
        } else {
            self.context = NSManagedObjectContext(coder: NSCoder())
        }
        super.init()
    }
    
    func load() -> [ImageAndText]? {
        let fetchRequest: NSFetchRequest<Record> = Record.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            var returnedResult: [ImageAndText] = []
            for item in results {
                
                guard let imageData = item.image, let image = UIImage(data: imageData) else { return nil }
                let text = item.text
                let imageAndText = ImageAndText(dbid: item.objectID, image: image, text: text)
                returnedResult.append(imageAndText)
            }
            return returnedResult
        } catch let error as NSError {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func save(item: ImageAndText) -> ImageAndText {
        
            guard let entity = NSEntityDescription.entity(forEntityName: "Record", in: context),
                  let record =  NSManagedObject(entity: entity, insertInto: context) as? Record else { return item }
            record.image = item.image.pngData()
            record.text = item.text
        do {
            try context.save()
            return ImageAndText(dbid: record.objectID, image: item.image, text: item.text)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return item
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
        guard let dbid = item.dbid else { return }
        // runtime error - reason: 'keypath dbid not found in entity Record'
        do {
            let fetchedObject = try context.existingObject(with: dbid)
            context.delete(fetchedObject)
            try context.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    
}
