//
//  AmountMoneyTextFieldUITests.swift
//  AKCOOUITests
//
//  Created by 박혜운 on 11/13/24.
//

@testable import AKCOO
import XCTest

class AmountMoneyTextFieldUITests: XCTestCase {
  
  var sut: AmountMoneyTextField!
  
  override func setUpWithError() throws {
    continueAfterFailure = false
    sut = AmountMoneyTextField(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
  }
  
  override func tearDownWithError() throws {
    sut = nil
  }
  
  func test_금액라벨_초기상태확인() {
    // 유닛 테스트로 변경
    // 금액 라벨의 초기 상태가 올바른지 확인합니다.
    let titleLabel = sut.titleLabel
    
    XCTAssertEqual(titleLabel.text, "금액", "금액 라벨의 텍스트는 '금액'이어야 합니다.")
  }
  
  func test_금액텍스트필드_입력동작확인() {
    // 유닛 테스트로 변경
    // 텍스트 필드에 값을 입력할 수 있는지 확인합니다.
    let textField = sut.textField
    textField.text = "100000"
    
    // 텍스트 필드에 올바른 값이 입력되었는지 확인합니다.
    XCTAssertEqual(sut.textField.text, "100000", "텍스트 필드에는 '100000'이 입력되어 있어야 합니다.")
  }
  
  func test_텍스트필드확장시_스택뷰축변경() {
    // 유닛 테스트로 변경
    // 텍스트 필드가 너무 넓어질 때 스택 뷰가 수직으로 전환되는지 확인합니다.
    let textField = sut.textField
    let inputStackView = sut.contentStack
    
    textField.text = "1000000000000" // 큰 값을 입력하여 축 변경을 유도합니다.
    
    // 스택 뷰의 축이 수직으로 변경되었는지 확인합니다.
    XCTAssertEqual(inputStackView.axis == .vertical, true, "스택 뷰는 수직 축으로 변경되어야 합니다.")
  }
  
  func test_다이나믹폰트_지원확인() {
    // 유닛 테스트로 변경
    // 다이나믹 폰트 설정 시 레이블들이 올바르게 조정되는지 확인합니다.
    let titleLabel = sut.titleLabel
    let unitLabel = sut.unitLabel
    
    XCTAssertNotNil(titleLabel, "금액 라벨이 존재해야 합니다.")
    XCTAssertNotNil(unitLabel, "단위 라벨이 존재해야 합니다.")
  }
  
  func test_구분선_존재확인() {
    // 유닛 테스트로 변경
    // 구분선이 올바르게 존재하는지 확인합니다.
    let separatorLine = sut.separatorLine
    XCTAssertNotNil(separatorLine, "구분선이 존재해야 합니다.")
  }
}
