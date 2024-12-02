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
  private var previousRecordExists: Bool = false
  
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
    animateDropWithSpring(delay: 0.2)
  }
  
  private func setupViews() {
    judgmentReadyView.onActionTappedClosedButton = { [weak self] in
      guard let self else { return }
      coordinator?.completedJudgment(judgmentViewController: self)
    }
    judgmentReadyView.paper.readyButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tappedReadyButton)))
    keyboardSetting()
  }
  
  private func setupUI() {
    Task {
      switch judgmentUseCase.getPaperModel() {
      case .success(let model):
        self.paperModel = model
        self.previousRecordExists = judgmentUseCase.isPreviousRecordExists(for: model.selectedCountryProfile.name, category: self.selectedCategory)
        judgmentReadyView.configure(paperModel: model, previousRecordExists: previousRecordExists)
      case .failure:
        // TODO: - 예외처리
        return
      }
    }
  }
  
  private func setupBubbleTextUI() {
    guard let paperModel else { return }
    self.previousRecordExists = judgmentUseCase.isPreviousRecordExists(for: paperModel.selectedCountryProfile.name, category: self.selectedCategory)
    judgmentReadyView.configurePreviousRecordExists(previousRecordExists, selectedCategory: self.selectedCategory)
  }
  
  private func onAction() {
    judgmentReadyView.paper.onActionChange(
      country: { [weak self] changedCountry in
        guard let self else { return }
        // PaperModel 변경
        Task {
          switch self.judgmentUseCase.getNewPaperModel(newCountryName: changedCountry) {
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
        self.selectedCategory = changedCategory ?? ""
        setupBubbleTextUI()
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
    dismissKeyboard()
    
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
  
  private func animateDropWithSpring(delay: CGFloat = 0) {
    // 초기 위치 설정 (시작점: 위쪽)
    let originalY = self.judgmentReadyView.paper.frame.origin.y
    judgmentReadyView.paper.frame.origin.y = originalY - 50 // 위로 이동해 시작 위치 설정
    
    // 스프링 애니메이션
    UIView.animate(
      withDuration: 0.8, // 애니메이션 지속 시간
      delay: delay,
      usingSpringWithDamping: 0.5, // 스프링 감쇠 비율 (낮을수록 더 많이 튕김)
      initialSpringVelocity: 2.0, // 초기 속도 (높을수록 빠르게 떨어짐)
      options: [.curveEaseInOut],
      animations: {
        // 최종 위치로 되돌리기 (원래 위치로 떨어짐)
        self.judgmentReadyView.paper.frame.origin.y = originalY
      },
      completion: nil
    )
  }
}

extension JudgmentReadyViewController: JudgmentCompletedViewControllerDelegate {
  func onActionCompletedDecision() {
    self.selectedCategory = ""
    self.userInputAmount = 0
    setupUI()
    animateDropWithSpring(delay: 0.3)
  }
}
