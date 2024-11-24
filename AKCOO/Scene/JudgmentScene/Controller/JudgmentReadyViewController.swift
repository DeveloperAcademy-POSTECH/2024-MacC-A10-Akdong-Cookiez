//
//  JudgmentSettingViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class JudgmentReadyViewController: UIViewController {
  weak var coordinator: JudgmentCoordinator?
  private let judgmentUseCase: JudgmentUseCase
  
  // MARK: View
  private var judgmentReadyView: JudgmentReadyView! {
    return view as? JudgmentReadyView
  }
  
  // MARK: Properties
  private var paperModel: PaperModel?
  private var selectedCategory: String = ""
  private var userInputAmount: Double?
  
  init(judgmentUseCase: JudgmentUseCase) {
    self.judgmentUseCase = judgmentUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = JudgmentReadyView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupUI()
    onAction()
  }
  
  private func setupViews() {
    judgmentReadyView.paper.readyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedReadyButton)))
    keyboardSetting()
  }
  
  private func setupUI() {
    Task {
      switch await judgmentUseCase.getPaperModel() {
      case .success(let paperModel):
        self.paperModel = paperModel
        judgmentReadyView.configure(paperModel: paperModel)
      case .failure:
        // TODO: - 예외처리
        return
      }
    }
  }
  
  private func onAction() {
    judgmentReadyView.paper.onActionChange(
      country: { [weak self] changedCountry in
        guard let self else { return }
        // PaperModel 변경
        Task {
          switch await self.judgmentUseCase.getNewPaperModel(newCountryName: changedCountry) {
          case .success(let newPaperModel):
            self.paperModel = newPaperModel
            self.setupUI()
          case .failure: return
            // TODO: - 예외처리
          }
        }
      },
      category: { [weak self] changedCategory in
        guard let self else { return }
        selectedCategory = changedCategory ?? ""
        print("\(changedCategory ?? "")로 카테고리 변경 되었으므로 저장해두기")
      },
      amount: { [weak self] changedAmount in
        guard let self else { return }
        self.userInputAmount = Double(changedAmount ?? "없는 값")
      }
    )
  }
  
  private func keyboardSetting() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    setupGestureRecognizers()
  }
  
  private func setupGestureRecognizers() {
    // 뷰 전체에 탭 제스처 추가 (키보드 내리기)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
    tapGesture.cancelsTouchesInView = false
    view.addGestureRecognizer(tapGesture)
  }
  
  @objc private func dismissKeyboard() {
    // 키보드를 내림
    view.endEditing(true)
  }
  
  @objc private func tappedReadyButton() {
    guard let paperModel, let userInputAmount else {
      // TODO: - 에러처리
      return
    }
    
    coordinator?.startJudgment(
      presenting: self,
      userQuestion: .init(
        country: paperModel.selectedCountryProfile,
        category: selectedCategory,
        amount: userInputAmount
      )
    )
  }
  
  @objc private func keyboardWillShow(_ notification: Notification) {
    guard 
      let userInfo = notification.userInfo,
      let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect else { return }

    let keyboardHeight = keyboardFrame.height
    let bottomPadding: CGFloat = 30 // 키보드 위의 간격
    judgmentReadyView.adjustPaperPositionForKeyboard(isVisible: true, keyboardHeight: keyboardHeight, bottomPadding: bottomPadding)
  }
  
  @objc private func keyboardWillHide(_ notification: Notification) {
    // 키보드가 사라지면 paper 뷰의 위치를 원래대로 복구
    judgmentReadyView.adjustPaperPositionForKeyboard(isVisible: false)
  }
}
