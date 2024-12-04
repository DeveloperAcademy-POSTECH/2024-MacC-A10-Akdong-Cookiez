//
//  UserInfoRecordsView.swift
//  AKCOO
//
//  Created by Anjin on 12/2/24.
//

import SwiftUI

@Observable
class UserInfoRecordsViewModel {
  var userRecords: [UserRecord] = []
}

struct UserInfoRecordsView: View {
  var viewModel: UserInfoRecordsViewModel
  
  var body: some View {
    VStack(alignment: .leading, spacing: 12) {
      HStack {
        Button {
          CoreDataService()
            .deleteAllUserRecords()
        } label: {
          Text("지출 판단 기록")
            .padding(.leading, 20)
            .foregroundStyle(Color(uiColor: .akColor(.black)))
        }
        
        Spacer()
      }
      
      LazyVStack(spacing: 10) {
        if viewModel.userRecords.isEmpty {
          VStack(spacing: 10) {
            HStack {
              Text("아직 기록이 없어요")
              Spacer()
            }
            .padding(.horizontal, 8)
            
            Line()
              .stroke(
                style: StrokeStyle(
                  lineWidth: 0.4,       // 선 두께
                  dash: [4, 2],         // 대시 패턴: [대시 길이, 간격]
                  dashPhase: 0          // 대시 시작 위치
                )
              )
              .foregroundColor(.black)  // 선 색상
              .frame(height: 1)         // 선 높이 조정
          }
        } else {
          ForEach(viewModel.userRecords, id: \.id) { record in
            VStack(spacing: 10) {
              HStack(spacing: 8) {
                Text(record.userQuestion.category)
                Spacer()
                
                let place: Int = record.userQuestion.country.name == "베트남" ? 0 : 2
                Text("\(record.userQuestion.amount.formattedWithCommas(maxDecimalPlaces: place)) \(record.userQuestion.country.currency.unitTitle)")
                Image(record.userJudgment == .buying ? .userRecordOmark : .confettiXmark)
                  .resizable()
                  .frame(width: 16, height: 16)
              }
              .padding(.horizontal, 8)
              
              Line()
                .stroke(
                  style: StrokeStyle(
                    lineWidth: 0.4,       // 선 두께
                    dash: [4, 2],         // 대시 패턴: [대시 길이, 간격]
                    dashPhase: 0          // 대시 시작 위치
                  )
                )
                .foregroundColor(.black)  // 선 색상
                .frame(height: 1)         // 선 높이 조정
            }
          }
        }
      }
      .padding(.vertical, 20)
      .padding(.horizontal, 25)
      .background(Color(uiColor: UIColor.akColor(.white)))
      .clipShape(RoundedRectangle(cornerRadius: 30))
    }
    .background(Color.clear)
    .font(Font.from(uiFont: UIFont.akFont(.gmarketMedium14)))
    .onAppear {
      print("이오링 userRecords\n\(try? CoreDataService().getUserRecord().get() ?? [])")
    }
  }
}
