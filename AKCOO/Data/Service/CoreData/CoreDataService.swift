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
}

// MARK: - CREATE
extension CoreDataService {
  /// CREATE - UserRecord 저장
  func saveUserRecord(_ userRecord: UserRecord) -> Result<VoidResponse, Error> {
    _ = UserRecord
      .toEntity(
        context: self.context,
        record: userRecord
      )
    
    // context 저장
    do {
      try self.context.save()
      return .success(VoidResponse())
    } catch {
      return .failure(error)
    }
  }
}

// MARK: - READ
extension CoreDataService {
  /// READ - UserRecord 불러오기
  func getUserRecord() -> Result<[UserRecord?], Error> {
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    do {
      let entities = try self.context.fetch(request)
      let userRecords = try entities.map {
        try UserRecord.fromEntity(entity: $0).get()
      }
      return .success(userRecords)
    } catch {
      return .failure(error)
    }
  }
  
  /// READ - 특정 나라의 UserRecord 불러오기
  func getUserRecord(at country: String?) -> Result<[UserRecord?], Error> {
    guard let country else { return self.getUserRecord() }
    
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    // 정렬 조건 추가: date 기준 내림차순 -> 데이터 1개만 가져오기
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    
    // 나라와 카테고리 조건 추가
    request.predicate = NSPredicate(format: "userQuestion.country.name == %@", country)
    
    do {
      let entities = try self.context.fetch(request)
      let userRecords = try entities.map {
        try UserRecord.fromEntity(entity: $0).get()
      }
      return .success(userRecords)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 특정 나라의 UserRecords 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// READ - 가장 최신의 UserRecord 불러오기
  func getLatestUserRecord(country: String, category: String) -> Result<UserRecord?, Error> {
    let request: NSFetchRequest<UserRecordEntity> = UserRecordEntity.fetchRequest()
    
    // 정렬 조건 추가: date 기준 내림차순 -> 데이터 1개만 가져오기
    request.sortDescriptors = [NSSortDescriptor(key: "date", ascending: false)]
    request.fetchLimit = 1
    
    // 나라와 카테고리 조건 추가
    request.predicate = NSPredicate(
      format: "userQuestion.country.name == %@ AND userQuestion.category == %@",
      country, category
    )
    
    do {
      guard let latestEntity = try context.fetch(request).first else {
        return .success(nil)
      }
      
      let latestUserRecord = try UserRecord.fromEntity(entity: latestEntity).get()
      
      return .success(latestUserRecord)
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 최근 UserRecord 1개 가져오기 실패 \(error)")
      return .failure(error)
    }
  }
}

// MARK: - DELETE
extension CoreDataService {
  /// DELETE - 특정 id의 UserRecord 삭제
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
      
      // context 저장
      do {
        try self.context.save()
        return .success(VoidResponse())
      } catch {
        return .failure(error)
      }
      
    } catch {
      // 실패
      print("🚨 DEBUG(ERROR): Coredata에서 UserRecord(id: \(id) 삭제 실패 \(error)")
      return .failure(error)
    }
  }
  
  /// DELETE - 모든 UserRecord 삭제
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
