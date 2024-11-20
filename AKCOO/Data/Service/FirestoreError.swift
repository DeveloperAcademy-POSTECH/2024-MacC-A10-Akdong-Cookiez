//
//  FirestoreError.swift
//  AKCOO
//
//  Created by Anjin on 11/20/24.
//

import Foundation

/// Firestore와 상호작용 중 발생할 수 있는 문제를 나타내는 에러 타입입니다.
enum FirestoreError: LocalizedError {
    
    /// Firestore 문서에 잘못된 데이터가 있거나 필요한 데이터가 누락된 경우를 나타냅니다.
    /// - Parameters:
    ///   - documentID: 문제가 발생한 Firestore 문서의 ID입니다.
    case invalidData(documentID: String)
    
    /// 에러가 발생한 상황에 대한 설명을 제공합니다.
    var errorDescription: String? {
        switch self {
        case .invalidData(let documentID):
            return "Firestore에서 ID가 \(documentID)인 문서에 유효하지 않은 데이터가 있습니다."
        }
    }
}
