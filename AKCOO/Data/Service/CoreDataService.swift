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
  
  init() {
    persistentContainer = NSPersistentContainer(name: "UserRecordModel")
    persistentContainer.loadPersistentStores { _, error in
      if let error = error {
        fatalError("Failed to load Core Data stack: \(error)")
      }
    }
  }
  
  var context: NSManagedObjectContext {
    return persistentContainer.viewContext
  }
  
  // TODO: save 별개로 분리 재고
  private func saveContext() -> Result<VoidResponse, Error> {
    guard self.context.hasChanges else { return .success(VoidResponse()) }
    
    do {
      try context.save()
      return .success(VoidResponse())
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 저장하기 실패 \(error)")
      return .failure(error)
    }
  }
  
  func saveUserRecord(_ userRecord: UserRecord) -> Result<VoidResponse, Error> {
    _ = UserRecord.toEntity(context: self.context, record: userRecord)
    
    switch self.saveContext() {
    case .success:
      return .success(VoidResponse())
    case .failure(let error):
      return .failure(error)
    }
  }
  
  func getUserRecord() -> Result<[UserRecord], Error> {
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    do {
      let entities = try self.context.fetch(request)
      return .success(entities.map { UserRecord.fromEntity(entity: $0) })
    } catch {
      return .failure(error)
    }
  }
  
  func getLatestUserRecord() -> Result<UserRecord, Error> {
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    // 정렬 조건 추가: date 기준 내림차순 -> 데이터 1개만 가져오기
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    request.fetchLimit = 1
    
    do {
      guard let latestEntity = try context.fetch(request).first else {
        return .failure(CoreDataError.getFailed)
      }
      
      return .success(UserRecord.fromEntity(entity: latestEntity))
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 최근 UserRecord 1개 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  func deleteUserRecord(by id: UUID) -> Result<VoidResponse, Error> {
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    // id를 기준으로 데이터를 필터링
    request.predicate = NSPredicate(format: "id == %@", id as CVarArg)
    
    do {
      // Fetch 요청 실행
      let userRecords = try context.fetch(request)
      guard let record = userRecords.first else {
        return .failure(CoreDataError.deleteFailed)
      }
      
      self.context.delete(record)
      
      switch self.saveContext() {
      case .success:
        return .success(VoidResponse())
      case .failure(let error):
        return .failure(error)
      }
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 UserRecord(id: \(id) 삭제 실패 \(error)")
      return .failure(error)
    }
  }
  
  func deleteAllUserRecords() {
      let request: NSFetchRequest<NSFetchRequestResult> = UserRecordEntity.fetchRequest()
      let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
      
      do {
          try context.execute(deleteRequest) // 모든 레코드 삭제
          try context.save()
          print("All records deleted successfully.")
      } catch {
          print("Failed to delete all records: \(error)")
      }
  }
}
