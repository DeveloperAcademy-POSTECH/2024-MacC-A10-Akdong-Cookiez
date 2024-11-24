//
//  AmountMoneyTextField.swift
//  AKCOO
//
//  Created by 박혜운 on 11/13/24.
//

import UIKit

private enum InputValidationResult {
  case valid(String)
  case invalidCharacters
  case outOfRange
}

class AmountMoneyTextField: UIView {
  
  // MARK: - Views
  private let contentStack = UIStackView().set {
    $0.accessibilityIdentifier = "ContentStackView"
    $0.axis = .horizontal
    $0.alignment = .trailing
    $0.distribution = .fill
    $0.spacing = 8
  }
  
  private let inputContainer = UIStackView().set {
    $0.accessibilityIdentifier = "InputContainerView"
    $0.axis = .horizontal
    $0.alignment = .trailing
    $0.distribution = .fill
    $0.spacing = 4
  }
  
  private lazy var titleLabel: UILabel = .paperLabel(with: "금액").set()
  
  let textField = UITextField().set {
    $0.accessibilityIdentifier = "AmountMoneyTextField"
    $0.borderStyle = .none
    $0.placeholder = "판단할 금액을 입력하세요"
    $0.font = UIFont.akFont(.gmarketBold20)
    $0.keyboardType = .decimalPad
    $0.textAlignment = .right
    $0.adjustsFontForContentSizeCategory = true
    $0.text = "0"
  }
  
  private let unitLabel = UILabel().set {
    $0.accessibilityIdentifier = "AmountMoneyUnitLabel"
    $0.text = "동"
    $0.font = UIFont.akFont(.gmarketBold20)
    $0.textColor = UIColor.akColor(.black)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let separatorLine = UIView().set {
    $0.accessibilityIdentifier = "AmountMoneySeparatorLine"
    $0.backgroundColor = UIColor.akColor(.black)
  }
  
  let infoLabel = UILabel().set {
    $0.accessibilityIdentifier = "AmountMoneyConvertKRWLabel"
    $0.text = "약 0 원"
    $0.font = UIFont.akFont(.gmarketMedium16)
    $0.textColor = UIColor.akColor(.akGray300)
    $0.adjustsFontForContentSizeCategory = true
  }
  
  // MARK: - Properties
  private var currency: Currency?
  var onActionValidInput: ((Bool) -> Void)?
  var onActionValidAmountInput: ((String?) -> Void)?
  
  // inputText 변경에 따른 모든 UI 업데이트
  var inputText: String = "0" {
    willSet {
      // 입력값 검증 및 업데이트
      let validationResult = validateInput(newValue)
      updateUI(for: validationResult)
    }
  }
  
  // MARK: - Initializers
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
  }
  
  // MARK: - Setup Methods
  private func setupViews() {
    addSubview(contentStack)
    addSubview(separatorLine)
    addSubview(infoLabel)
    
    contentStack.addArrangedSubview(titleLabel)
    contentStack.addArrangedSubview(inputContainer)
    
    inputContainer.addArrangedSubview(textField)
    inputContainer.addArrangedSubview(unitLabel)
    
    textField.delegate = self
    textField.addTarget(self, action: #selector(onTextChanged), for: .editingChanged)
    textField.addTarget(self, action: #selector(onEditingBegin), for: .editingDidBegin)
  }
  
  private func setupConstraints() {
    let innerVerticalPadding: CGFloat = 9
    NSLayoutConstraint.activate([
      contentStack.topAnchor.constraint(equalTo: topAnchor),
      contentStack.leadingAnchor.constraint(equalTo: leadingAnchor),
      contentStack.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      separatorLine.topAnchor.constraint(equalTo: contentStack.bottomAnchor, constant: innerVerticalPadding),
      separatorLine.heightAnchor.constraint(equalToConstant: 0.5),
      separatorLine.leadingAnchor.constraint(equalTo: leadingAnchor),
      separatorLine.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      infoLabel.topAnchor.constraint(equalTo: separatorLine.bottomAnchor, constant: innerVerticalPadding),
      infoLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
      infoLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
    
    unitLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
    unitLabel.setContentHuggingPriority(.required, for: .horizontal)
    textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
  }
  
  // MARK: - Configuration
  func configure(currency: Currency, amount: String = "0") {
    self.currency = currency
    self.unitLabel.text = currency.unitTitle
    self.inputText = amount
  }
  
  // MARK: - Input Handling
  @objc private func onTextChanged() {
    self.inputText = textField.text?.removingCommas() ?? "0"
  }
  
  @objc private func onEditingBegin() {
    moveCursorToEnd()
  }
  
  // MARK: - Helpers
  private func validateInput(_ input: String) -> InputValidationResult {
    let allowedCharacterSet = CharacterSet.decimalDigits.union(CharacterSet(charactersIn: "."))
    
    // Empty input or invalid characters
    guard !input.isEmpty else { return .valid("0") }
    guard CharacterSet(charactersIn: input).isSubset(of: allowedCharacterSet) else { return .invalidCharacters }
    
    // Ensure only one `.` exists
    let components = input.split(separator: ".")
    if components.count > 2 {
      return .invalidCharacters
    }
    
    // Prevent leading "00"
    if input.hasPrefix("00") {
      return .valid("0")
    }
    
    // Restrict decimal places to a maximum of 2
    if let decimalPart = components.last, components.count == 2, decimalPart.count > 2 {
      return .outOfRange
    }
    
    // Maximum 12 digits excluding the `.` and decimals
    let numericInput = input.replacingOccurrences(of: ".", with: "").removingCommas()
    if numericInput.count > 12 {
      return .outOfRange
    }
    return .valid(input)
  }
  
  private func updateUI(for validationResult: InputValidationResult) {
    switch validationResult {
    case .valid(let validInput):
      // TextField 업데이트
      textField.text = formatNumber(validInput)
      onActionValidAmountInput?(validInput)
      // InfoLabel 업데이트
      guard let currency else { return }
      let amount = calculateLocalAmount(for: currency, input: validInput)
      infoLabel.text = "약 \(amount) 원"
      infoLabel.textColor = UIColor.akColor(.akGray300)
      
      // Action Callback
      onActionValidInput?(validInput != "0")
    case .invalidCharacters:
      infoLabel.text = "숫자만 입력할 수 있어요"
      infoLabel.textColor = UIColor.akColor(.akRed)
      onActionValidInput?(false)
      onActionValidAmountInput?(nil)
    case .outOfRange:
      infoLabel.text = "12자리 숫자까지 입력할 수 있어요"
      infoLabel.textColor = UIColor.akColor(.akRed)
      textField.text = String(textField.text?.dropLast() ?? "")
      onActionValidInput?(false)
      onActionValidAmountInput?(nil)
    }
  }
  
  private func formatNumber(_ input: String) -> String {
    // Remove commas for processing
    let cleanedInput = input.removingCommas()
    
    // Handle decimal part separately
    let components = cleanedInput.split(separator: ".")
    guard let integerPart = components.first else { return "0" }
    let formattedInteger = String(integerPart).formatWithComma() ?? "0"
    
    // Preserve trailing decimal point (e.g., "0.")
    if cleanedInput.hasSuffix(".") {
      return "\(formattedInteger)."
    }
    
    // Append decimal part if present
    if components.count == 2, let decimalPart = components.last {
      return "\(formattedInteger).\(decimalPart)"
    }
    
    return formattedInteger
  }
  
  private func calculateLocalAmount(for currency: Currency, input: String) -> String {
    guard let num = Double(input) else { return "0" }
    let result = num * currency.unit
    return String(result).formatWithComma() ?? "0"
  }
  
  private func moveCursorToEnd() {
    DispatchQueue.main.async { [weak self] in
      guard let self else { return }
      let endPosition = self.textField.endOfDocument
      self.textField.selectedTextRange = self.textField.textRange(from: endPosition, to: endPosition)
    }
  }
}

// MARK: - UITextFieldDelegate
extension AmountMoneyTextField: UITextFieldDelegate {
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    let allowedCharacterSet = CharacterSet(charactersIn: "0123456789.")
    let characterSet = CharacterSet(charactersIn: string)
    
    // 입력값이 허용된 문자 집합에 포함되지 않으면 차단
    if !allowedCharacterSet.isSuperset(of: characterSet) {
      return false
    }
    
    // 현재 텍스트 필드 값
    let currentText = textField.text ?? ""
    
    // 새로 입력될 텍스트 예상 값
    let newText = (currentText as NSString).replacingCharacters(in: range, with: string)
    
    // 소수점은 한 번만 허용
    if string == ".", currentText.contains(".") {
      return false
    }
    
    // 소수점 뒤 최대 2자리까지만 허용
    let components = newText.split(separator: ".")
    if components.count == 2, components[1].count > 2 {
      return false
    }
    
    // "00"으로 시작하는 경우 허용하지 않음 (단, "0."은 허용)
    if newText.hasPrefix("00") && !newText.hasPrefix("0.") {
      return false
    }
    return true
  }
}

#Preview {
  let preview = AmountMoneyTextField().set()
  preview.configure(
    currency: .init(unitTitle: "동", unit: 0.05539),
    amount: "10000"
  )
  return preview
}
