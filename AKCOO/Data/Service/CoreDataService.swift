//
//  CoreDataService.swift
//  AKCOO
//
//  Created by Anjin on 11/21/24.
//

import CoreData
import Foundation

struct CoreDataService {
  let persistentContainer: NSPersistentContainer
  
  private init() {
    persistentContainer = NSPersistentContainer(name: "UserRecordModel")
    persistentContainer.loadPersistentStores { description, error in
      if let error = error {
        fatalError("Failed to load Core Data stack: \(error)")
      }
    }
  }
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  func saveContext() {
    if self.context.hasChanges {
      do {
        try context.save()
      } catch {
        // 실패
        print("🚨 DEBUG(ERROR): Coredata에서 저장하기 실패 \(error)")
      }
    }
  }
  
  func saveUserRecord() {
    if let userRecordEntity = NSEntityDescription.entity(
      forEntityName: "UserRecord",
      in: self.context
    ) {
      let userRecord = NSManagedObject(entity: userRecordEntity, insertInto: self.context)
      
    }
  }
}
