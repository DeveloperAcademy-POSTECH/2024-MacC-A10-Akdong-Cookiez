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
    
    // Do any additional setup after loading the view.
  }
  
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destination.
   // Pass the selected object to the new view controller.
   }
   */
  
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}
