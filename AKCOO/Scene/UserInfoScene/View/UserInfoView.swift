//
//  UserInfoView.swift
//  AKCOO
//
//  Created by 박혜운 on 12/2/24.
//

import SwiftUI
import UIKit

class UserInfoView: UIView {
  
  let scrollView = UIScrollView().set {
    $0.backgroundColor = .akColor(.akGray100)
    $0.isScrollEnabled = true
  }
  
  let contentView = UIView().set {
    $0.backgroundColor = .red
  }
  
  let grayBackgroundView = UIView().set {
    $0.backgroundColor = .akColor(.akGray100)
  }
  
  let titleView = UserInfoTitleView().set()
  let birdView = UserInfoBirdView().set()
  let descriptionView = UserInfoDescriptionView().set()
  
  private let userRecordViewModel = UserInfoRecordsViewModel()
  lazy var userRecordsView = UIHostingController(rootView: UserInfoRecordsView(viewModel: userRecordViewModel)).view.set {
    $0.backgroundColor = .clear
  }
  
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
  
  private func setupViews() {
    addSubview(scrollView)
    scrollView.addSubview(contentView)
    
    contentView.addSubview(grayBackgroundView)
    contentView.addSubview(titleView)
    contentView.addSubview(birdView)
    contentView.addSubview(descriptionView)
    contentView.addSubview(userRecordsView)
  }
  
  private func setupConstraints() {
    let titlePadding: CGFloat = 33
    let birdLeadingPadding: CGFloat = 20
    let birdTrailingPadding: CGFloat = 34
    
    NSLayoutConstraint.activate([
      // scrollView
      scrollView.topAnchor.constraint(equalTo: topAnchor),
      scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
      scrollView.leadingAnchor.constraint(equalTo: leadingAnchor),
      scrollView.trailingAnchor.constraint(equalTo: trailingAnchor),
      
      // contentView
      contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
      contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
      contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
      contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
      contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
      
      grayBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
      grayBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      grayBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      grayBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      
      titleView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
      titleView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: titlePadding),
      titleView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -titlePadding),
      
      birdView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 50),
      birdView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: birdLeadingPadding),
      birdView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -birdTrailingPadding),
      
      descriptionView.topAnchor.constraint(equalTo: birdView.bottomAnchor, constant: 8),
      descriptionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      descriptionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      
      userRecordsView.topAnchor.constraint(equalTo: descriptionView.bottomAnchor, constant: 18),
      userRecordsView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
      userRecordsView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
      userRecordsView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    ])
  }
  
  func configure(userJudgmentTypeModel: UserJudgmentTypeModel) {
    let model = userJudgmentTypeModel
    
    userRecordViewModel.userRecords = model.userRecords
    
    titleView
      .configure(
        title: model.title,
        boldTitle: model.boldTitle
      )
    
    birdView
      .configure(
        birdType: model.userBirdType,
        leftChat: model.getBirdChat(at: .left),
        rightTopChat: model.getBirdChat(at: .rightTop),
        rightBottomChat: model.getBirdChat(at: .rightBottom)
      )
    
    descriptionView
      .configure(
        title: model.descriptionTitle,
        description: model.descriptionContents
      )
  }
}

#Preview {
  UserInfoViewController(userInfoUseCase: UserInfoUseCaseMock())
}
