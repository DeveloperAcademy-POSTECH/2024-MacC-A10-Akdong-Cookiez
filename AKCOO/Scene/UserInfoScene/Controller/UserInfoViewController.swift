//
//  UserInfoViewController.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import UIKit

class UserInfoViewController: UIViewController {
  weak var coordinator: UserInfoCoordinator?
  private let userInfoUseCase: UserInfoUseCase
  
  // MARK: View
  private var userInfoView: UserInfoView! {
    return view as? UserInfoView
  }
  
  init(userInfoUseCase: UserInfoUseCase) {
    self.userInfoUseCase = userInfoUseCase
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func loadView() {
    view = UserInfoView()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    switch userInfoUseCase.getUserJudgmentTypeModel() {
    case .success(let userJudgmentTypeModel):
      userInfoView.configure(userJudgmentTypeModel: userJudgmentTypeModel)
    case .failure:
      // TODO: 예외처리
      return
    }
  }
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}
