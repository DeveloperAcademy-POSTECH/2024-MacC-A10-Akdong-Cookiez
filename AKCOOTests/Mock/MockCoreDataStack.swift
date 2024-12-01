//
//  MockCoreDataStack.swift
//  AKCOOTests
//
//  Created by Anjin on 12/2/24.
//

import CoreData
import XCTest

final class MockCoreDataStack {
  static func makeInMemoryPersistentContainer() -> NSPersistentContainer {
    let container = NSPersistentContainer(name: "UserRecordModel")
    
    let description = NSPersistentStoreDescription()
    description.type = NSInMemoryStoreType
    container.persistentStoreDescriptions = [description]
    
    container.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Failed to load in-memory store: \(error)")
      }
    }
    return container
  }
}
