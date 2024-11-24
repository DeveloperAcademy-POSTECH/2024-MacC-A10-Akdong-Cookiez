//
//  AmountMoneyTextFieldUITests.swift
//  AKCOOUITests
//
//  Created by 박혜운 on 11/13/24.
//

@testable import AKCOO
import XCTest

class AmountMoneyTextFieldTests: XCTestCase {
  
  var textField: AmountMoneyTextField!
  var currency: Currency!
  
  override func setUp() {
    super.setUp()
    textField = AmountMoneyTextField()
    currency = Currency(unitTitle: "동", unit: 0.05539)
    textField.configure(currency: currency, amount: "0")
  }
  
  override func tearDown() {
    textField = nil
    currency = nil
    super.tearDown()
  }
  
  func test_초기_상태_확인() {
    XCTAssertEqual(textField.inputText, "0", "초기 inputText는 '0'이어야 합니다.")
    XCTAssertEqual(textField.textField.text, "0", "초기 textField.text는 '0'이어야 합니다.")
    XCTAssertEqual(textField.infoLabel.text, "약 0 원", "초기 infoLabel은 '약 0원'을 표시해야 합니다.")
  }
  
  func test_유효한_숫자_입력() {
    textField.inputText = "12345"
    XCTAssertEqual(textField.inputText, "12345", "inputText는 업데이트되어야 합니다.")
    XCTAssertEqual(textField.textField.text, "12,345", "textField.text는 콤마로 포맷팅되어야 합니다.")
    XCTAssertEqual(textField.infoLabel.text, "약 678.98 원", "infoLabel은 변환된 값을 올바르게 표시해야 합니다.")
  }
  
  func test_잘못된_문자_입력() {
    textField.inputText = "12abc"
    XCTAssertEqual(textField.infoLabel.text, "숫자만 입력할 수 있어요", "infoLabel은 잘못된 문자 입력에 대한 에러 메시지를 표시해야 합니다.")
    XCTAssertEqual(textField.infoLabel.textColor, .akColor(.akRed), "infoLabel은 잘못된 입력 시 빨간색이어야 합니다.")
  }
  
  func test_입력_자릿수_초과() {
    textField.inputText = "1234567890123"
    XCTAssertEqual(textField.infoLabel.text, "12자리 숫자까지 입력할 수 있어요", "infoLabel은 자릿수 초과에 대한 에러 메시지를 표시해야 합니다.")
    XCTAssertEqual(textField.infoLabel.textColor, .akColor(.akRed), "infoLabel은 초과 입력 시 빨간색이어야 합니다.")
  }
  
  func test_소수점_입력() {
    textField.inputText = "12345.67"
    XCTAssertEqual(textField.inputText, "12345.67", "inputText는 소수점을 포함해야 합니다.")
    XCTAssertEqual(textField.textField.text, "12,345.67", "textField.text는 소수점 포함 포맷팅을 적용해야 합니다.")
    XCTAssertEqual(textField.infoLabel.text, "약 670.01 원", "infoLabel은 변환된 값을 올바르게 표시해야 합니다.")
  }
  
  func test_소수점_두_자리_제한() {
    textField.inputText = "12345.678"
    XCTAssertEqual(textField.textField.text, "12,345.67", "textField.text는 소수점 이하 2자리까지만 표시해야 합니다.")
  }
  
  func test_선행_0_제거() {
    textField.inputText = "000123"
    XCTAssertEqual(textField.inputText, "123", "선행 0은 제거되어야 합니다.")
    XCTAssertEqual(textField.textField.text, "123", "textField.text는 선행 0 없이 표시되어야 합니다.")
  }
  
  func test_0_입력() {
    textField.inputText = "0"
    XCTAssertEqual(textField.inputText, "0", "inputText는 '0'이어야 합니다.")
    XCTAssertEqual(textField.textField.text, "0", "textField.text는 '0'으로 표시되어야 합니다.")
    XCTAssertEqual(textField.infoLabel.text, "약 0 원", "infoLabel은 '약 0원'을 표시해야 합니다.")
  }
  
  func test_입력_유효성_콜백() {
    var callbackCalled = false
    var callbackValue: Bool?
    
    textField.onActionValidInput = { isValid in
      callbackCalled = true
      callbackValue = isValid
    }
    
    textField.inputText = "12345"
    XCTAssertTrue(callbackCalled, "inputText가 변경될 때 onActionInputNum 콜백이 호출되어야 합니다.")
    XCTAssertEqual(callbackValue, true, "유효한 입력에 대해 콜백은 'true'를 전달해야 합니다.")
    
    callbackCalled = false
    textField.inputText = "0"
    XCTAssertTrue(callbackCalled, "inputText가 '0'으로 변경될 때 콜백이 호출되어야 합니다.")
    XCTAssertEqual(callbackValue, false, "입력이 '0'일 경우 콜백은 'false'를 전달해야 합니다.")
  }
}
