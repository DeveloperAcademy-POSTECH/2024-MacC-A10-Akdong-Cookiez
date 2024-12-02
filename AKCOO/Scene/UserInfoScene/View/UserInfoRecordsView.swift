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
        Text("지출 판단 기록")
          .padding(.leading, 20)
        Spacer()
        Button {
          CoreDataService().deleteAllUserRecords()
        } label: {
          Text("다 지우자")
        }
      }
      
      LazyVStack(spacing: 10) {
        if viewModel.userRecords.isEmpty {
          HStack {
            Spacer()
            Text("아직 지출 판단 기록이 없어요")
              .multilineTextAlignment(.center)
            Spacer()
          }
        } else {
          ForEach(viewModel.userRecords, id: \.id) { record in
            VStack(spacing: 10) {
              HStack(spacing: 8) {
                Text(record.userQuestion.category)
                Spacer()
                Text("\(record.userQuestion.amount.formattedWithCommas(maxDecimalPlaces: 0))\(record.userQuestion.country.currency.unitTitle)")
                Image(record.userJudgment == .buying ? .confettiOmark : .confettiXmark)
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
  }
}
