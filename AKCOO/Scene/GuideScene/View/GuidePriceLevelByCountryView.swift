//
//  GuidePriceLevelByCountryView.swift
//  AKCOO
//
//  Created by Anjin on 12/3/24.
//

import SwiftUI

@Observable
class GuidePriceLevelByCountryViewModel {
  var countryDetail: CountryDetail = .init(
    country: CountryProfile(
      name: "베트남",
      currency: Currency(unitTitle: "동", unit: 0.055)
    ),
    items: []
  )
}

struct GuidePriceLevelByCountryView: View {
  var viewModel: GuidePriceLevelByCountryViewModel
  var country: CountryDetail {
    viewModel.countryDetail
  }
  
  var body: some View {
    VStack(spacing: 12) {
      HStack {
        Text("\(country.name) 물가 정보")
          .font(Font.from(uiFont: UIFont.akFont(.gmarketMedium14)))
        Spacer()
      }
      .padding(.horizontal, 34)
      
      ScrollView(.horizontal, showsIndicators: false) {
        HStack {
          currencyView()
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .background(Color(uiColor: .akColor(.white)))
            .clipShape(RoundedRectangle(cornerRadius: 30))
          
          ForEach(country.categories, id: \.self) { category in
            // FIXME: filter를 걸고 ForEach를 돌 수 있도록 변경 (일단 급해서 엉엉ㅠㅜ)
            let items: [Item] = country.items.filter { $0.category == category }
            
            VStack(alignment: .leading, spacing: 15) {
              Text("\(category) 평균 가격 정보")
                .font(Font.from(uiFont: UIFont.akFont(.gmarketBold14)))
              
              ForEach(items, id: \.self) { item in
                VStack(alignment: .leading, spacing: 5) {
                  Text(item.name)
                    .font(Font.from(uiFont: UIFont.akFont(.gmarketMedium14)))
                  
                  Text("\(item.amount.formattedWithCommas())\(country.currency.unitTitle)")
                    .font(Font.from(uiFont: UIFont.akFont(.gmarketBold16)))
                }
              }
              
              if category != mostFrequentCategory() {
                Spacer()
              }
            }
            .padding(.vertical, 24)
            .padding(.horizontal, 20)
            .background(Color(uiColor: .akColor(.white)))
            .clipShape(RoundedRectangle(cornerRadius: 30))
          }
        }
        .padding(.horizontal, 12)
      }
    }
  }
  
  @ViewBuilder
  private func currencyView() -> some View {
    VStack(alignment: .leading, spacing: 15) {
      Text("환율")
        .font(Font.from(uiFont: UIFont.akFont(.gmarketBold14)))
      
      Text(getExchangeDescription())
        .font(Font.from(uiFont: UIFont.akFont(.gmarketBold16)))
      
      Spacer()
      
      Text("한국 대비 \(country.name == "베트남" ? "저렴함" : "비쌈")")
        .font(Font.from(uiFont: UIFont.akFont(.gmarketMedium16)))
        .background(Color(uiColor: .akColor(.akOrange)))
    }
  }
  
  private func getExchangeDescription() -> String {
    let multipleValue: Double = country.name == "베트남" ? 100 : 1
    let maxDecimalPlaces: Int = country.currency.unit > 1000 ? 0 : 2
    return "\(multipleValue.formattedWithCommas(maxDecimalPlaces: 0))\(country.currency.unitTitle) = \((country.currency.unit * multipleValue).formattedWithCommas(maxDecimalPlaces: maxDecimalPlaces))원"
  }
  
  func mostFrequentCategory() -> String? {
    var frequency: [String: Int] = [:]
    
    for item in country.items {
      frequency[item.category, default: 0] += 1
    }
    
    return frequency.max { $0.value < $1.value }?.key
  }
}

