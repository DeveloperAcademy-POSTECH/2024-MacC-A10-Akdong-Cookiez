//
//  ReactionResultsView.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

class ReactionBirdTextView: UIView {
  let backgroundView = UIView(frame: .zero).set {
    $0.clipsToBounds = true
  }
  
  private let titleLabel = UILabel().set {
    $0.text = "베트남 10년차 "
    $0.font = UIFont.preferredFont(forTextStyle: .title1)
    $0.textAlignment = .left
    $0.adjustsFontForContentSizeCategory = true
  }
  
  private let opinionLabel = UILabel().set {
    $0.text = "\"너무비싼데... 정말 필요해?\""
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
  }
  
  private let detailLabel = UILabel().set {
    $0.text =
  """
  아메리카노보다 2000동 저렴해요
  로컬 카페 <하이랜드커피>의 M사이즈
  아메리카노보다 2000동 저렴해요
  로컬 카페 <하이랜드커피>의 M사이즈
  """
    $0.numberOfLines = 0
    $0.font = UIFont.systemFont(ofSize: 16, weight: .medium)
    $0.textColor = .black
    $0.isHidden = true
  }
  
  private var isExpanded = false
  private var backgroundBottomConstraint: NSLayoutConstraint?
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupViews()
    setupConstraints()
    configureInitialState()
    
    backgroundView.backgroundColor = .green
  }
  
  required init?(coder: NSCoder) {
    super.init(coder: coder)
    setupViews()
    setupConstraints()
    configureInitialState()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    setLayout()
  }
  
  private func setupViews() {
    addSubview(backgroundView)
    
    backgroundView.addSubview(titleLabel)
    backgroundView.addSubview(opinionLabel)
    backgroundView.addSubview(detailLabel)
    
    //    addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleView)))
  }
  
  private func setupConstraints() {
    let verticalPadding: CGFloat = 26
    
    backgroundBottomConstraint =
    self.backgroundView.bottomAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: verticalPadding)
    
    //        let topConstraint = opinionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4)
    //        topConstraint.priority = UILayoutPriority(999) // 우선순위 높게 설정
    
    NSLayoutConstraint.activate([
      backgroundView.topAnchor.constraint(equalTo: topAnchor),
      
      backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
      backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundBottomConstraint!,
      
      titleLabel.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: verticalPadding),
      titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
      
      opinionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
      opinionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: 1),
      
      detailLabel.topAnchor.constraint(equalTo: opinionLabel.bottomAnchor, constant: 10)
    ])
  }
  
  private func configureInitialState() {
    translatesAutoresizingMaskIntoConstraints = false
    detailLabel.isHidden = true
  }
  
  func toggleView() {
    isExpanded.toggle()
    
    // 변경되어야 할 폰트
    let newTitleFont = isExpanded ? UIFont.preferredFont(forTextStyle: .caption1) : UIFont.preferredFont(forTextStyle: .title1)
    
    // 스냅샷 화면에 추가
    guard let titleSnapshot = titleLabel.snapshotView(afterScreenUpdates: true) else { return }
    titleSnapshot.frame = titleLabel.frame
    guard let opinionSnapshot = opinionLabel.snapshotView(afterScreenUpdates: true) else { return }
    opinionSnapshot.frame = opinionLabel.frame
    
    addSubview(titleSnapshot)
    addSubview(opinionSnapshot)
    
    // 기존값 감춤
    titleLabel.font = newTitleFont
    titleLabel.sizeToFit()
    titleLabel.alpha = 0
    
    opinionLabel.sizeToFit()
    opinionLabel.alpha = 0
    
    let scaleX = self.titleLabel.frame.width / titleSnapshot.frame.width
    let scaleY = self.titleLabel.frame.height / titleSnapshot.frame.height
    
    self.layoutIfNeeded()
    
    UIView.animate(withDuration: 0.5, delay: 0, options: [.curveEaseInOut], animations: { [weak self] in
      guard let self else { return }
      self.detailLabel.isHidden = isExpanded
      // titleLabel 애니메이션
      titleSnapshot.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
      titleSnapshot.frame.origin = self.titleLabel.frame.origin
      
      opinionSnapshot.frame.origin = self.opinionLabel.frame.origin
      
      // isExpanded 여부에 따른 제약 조건 업데이트
      if self.isExpanded {
        self.backgroundBottomConstraint?.isActive = false
        self.backgroundBottomConstraint = self.backgroundView.bottomAnchor.constraint(equalTo: self.detailLabel.bottomAnchor, constant: 26)
        self.backgroundBottomConstraint?.isActive = true
        self.detailLabel.isHidden = false
      } else {
        self.detailLabel.isHidden = true
        self.backgroundBottomConstraint?.isActive = false
        self.backgroundBottomConstraint = self.backgroundView.bottomAnchor.constraint(equalTo: self.opinionLabel.bottomAnchor, constant: 26)
        self.backgroundBottomConstraint?.isActive = true
      }
      
      // 변경된 제약 조건에 따른 레이아웃 강제 갱신
      self.layoutIfNeeded()
      
    }, completion: { [weak self] _ in
      guard let self = self else { return }
      // 스냅샷 제거 후 실제 라벨 표시
      self.titleLabel.alpha = 1
      titleSnapshot.removeFromSuperview()
      
      self.opinionLabel.alpha = 1
      opinionSnapshot.removeFromSuperview()
    })
  }
  
  private func setLayout() {
    backgroundView.layer.cornerRadius = 30
    backgroundView.layer.masksToBounds = true
  }
}

// Preview 화면
#Preview {
  let preview = ReactionBirdTextView()
  return preview
}
