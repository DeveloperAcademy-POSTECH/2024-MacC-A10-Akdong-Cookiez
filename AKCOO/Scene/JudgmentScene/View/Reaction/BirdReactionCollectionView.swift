import UIKit

class BirdReactionCollectionView: UIView {
  // MARK: - Views
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .vertical
    layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
    layout.minimumLineSpacing = 30
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    collectionView.backgroundColor = .blue
    collectionView.delegate = self
    collectionView.dataSource = self
    collectionView.register(BirdReactionCell.self, forCellWithReuseIdentifier: BirdReactionCell.identifier)
    return collectionView
  }()
  
  // MARK: - Properties
  private var reactionResults: [BirdReactionTextView] = []
  
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
    addSubview(collectionView)
  }
  
  private func setupConstraints() {
    NSLayoutConstraint.activate([
      collectionView.topAnchor.constraint(equalTo: topAnchor),
      collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
    ])
  }
  
  // MARK: - Public Methods
  func configure(with reactionResults: [BirdReactionTextView]) {
    // TODO: - cell 재정의 후 올라가는 화면 전체적으로 수정
    self.reactionResults = reactionResults
    reactionResults.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    collectionView.reloadData()
  }
}

// MARK: - UICollectionViewDataSource
extension BirdReactionCollectionView: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return reactionResults.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BirdReactionCell.identifier, for: indexPath) as? BirdReactionCell else {
      return UICollectionViewCell()
    }
    cell.alpha = 0
    cell.configure(with: reactionResults[indexPath.item])
    
    // 초기 상태 설정 (셀을 화면 위로 이동)
    cell.transform = CGAffineTransform(translationX: collectionView.frame.width*2, y: 0)
    
    UIView.animate(
      withDuration: 0.4, // 좀 더 오래 지속되는 애니메이션
      delay: 0.3 * Double(indexPath.item), // 각 셀이 약간의 시간 차이를 두고 등장
      usingSpringWithDamping: 0.9, // 스프링 효과를 줄 때 사용 (0에 가까울수록 더 강한 스프링)
      initialSpringVelocity: 0.5, // 초기 스프링 속도
      options: [.curveEaseInOut],
      animations: {
        cell.transform = .identity // 원래 위치로 이동
        cell.alpha = 1 // 투명도 정상화
      },
      completion: nil
    )
    
    return cell
  }
}

// MARK: - UICollectionViewDelegate
extension BirdReactionCollectionView: UICollectionViewDelegate {
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    print("Cell at index \(indexPath.item) selected")
    let selectedView = reactionResults[indexPath.item]
    selectedView.toggleView()
    //    collectionView.reloadItems(at: [indexPath])
    collectionView.performBatchUpdates(nil, completion: nil)
  }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension BirdReactionCollectionView: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = collectionView.frame.width // Inset adjustment
    let targetView = reactionResults[indexPath.item]
    let targetHeight = targetView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
    return CGSize(width: width, height: targetHeight)
  }
}

// Preview for ReactionCollectionView
#Preview {
  let preview = BirdReactionCollectionView()
  preview.configure(with: [BirdReactionTextView(), BirdReactionTextView(), BirdReactionTextView()])
  return preview
}
