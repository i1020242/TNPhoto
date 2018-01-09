//
//  MTCoredataService.swift
//  TNImage
//
//  Created by Nguyễn Minh Trí on 1/4/18.
//  Copyright © 2018 Nguyễn Minh Trí. All rights reserved.
//

import Foundation
import CoreData

class MTCoredataService:NSObject {
    // MARK: - Core Data stack
    
    open lazy var applicationDocumentsDirectory: NSURL = {
        // The directory the application uses to store the Core Data store file.
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1] as NSURL
    }()
    
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        // The managed object model for the application.
        let modelURL = Bundle.main.url(forResource: "ImageData", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    open lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: self.managedObjectModel)
        let url = self.applicationDocumentsDirectory.appendingPathComponent("MyCoreDataProject.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType,
                                               configurationName: nil,
                                               at: url, options: nil)
        } catch {
            // Report any error we got.
            abort()
        }
        
        return coordinator
    }()
    
    open lazy var managedObjectContext: NSManagedObjectContext? = {
        // Returns the managed object context for the application
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    func savePhoto(title:String, previewImage:String, fullImage:String) {
        let entity =  NSEntityDescription.entity(forEntityName: "Image", in:managedObjectContext!)
        let item = NSManagedObject(entity: entity!, insertInto:managedObjectContext!)
        item.setValue(previewImage, forKey: "urlPreview")
        item.setValue(title, forKey: "title")
        item.setValue(fullImage, forKey: "urlFull")
        do {
            try managedObjectContext!.save()
        } catch _ {
            print("Something went wrong.")
        }
    }
    
    func deletePhoto(photo:Image, completionHandler:()->Void){
        managedObjectContext?.delete(photo)
        do {
            try managedObjectContext!.save()
            completionHandler()
        } catch _ {
            print("Something went wrong.")
        }
    }
    
    func fetchAndPrintEachPerson(keywork:String, completionHandler:(_ ahihi:[Image])->Void) {
        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
        fetchRequest.predicate = NSPredicate(format: "title contains[c] %@", keywork)
        do {
            let fetchedResults = try managedObjectContext!.fetch(fetchRequest)
            var arrTemp:[Image] = []
            for item in fetchedResults {
                arrTemp.append(item)
            }
            completionHandler(arrTemp)
        } catch let error as NSError {
            print(error.description)
        }
    }
}
