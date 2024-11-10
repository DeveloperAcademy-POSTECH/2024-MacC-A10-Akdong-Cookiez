//
//  TravelSearchView.swift
//  AKCOO
//
//  Created by KIM SEOWOO on 11/10/24.
//

import UIKit

class TravelSearchView: UIViewController {
  
  private let containerView = UIView().set {
    $0.backgroundColor = UIColor.akColor(.gray1)
    $0.layer.borderWidth = 0.3
    $0.layer.borderColor = UIColor.akColor(.black).cgColor
  }

  private let searchTextField = UITextField().set {
    $0.font = UIFont.akFont(.gmarketMedium32)
    $0.setPlaceholder(text: "국가를 검색하세요", font: .akFont(.gmarketLight16), color: .akColor(.gray3))
    
    $0.borderStyle = .none
    $0.textAlignment = .left
    $0.adjustsFontForContentSizeCategory = true
    }
  
  private let searchGlassImage = UIImageView().set {
    $0.image = UIImage(named: "searchGlass")
  }

  private let resultsTableView: UITableView = {
      let tableView = UITableView()
      tableView.translatesAutoresizingMaskIntoConstraints = false
      return tableView
    }()

  private var allDestinations = ["apple", "applePie", "ayo", "banna", "helloa", "hhha"]
  private var filteredDestinations: [String] = []

  override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupTableView()
        setupTextField()
    }

    private func setupUI() {
        view.backgroundColor = .cyan
        view.addSubview(searchTextField)
        view.addSubview(resultsTableView)

        NSLayoutConstraint.activate([
            searchTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchTextField.heightAnchor.constraint(equalToConstant: 40),

            resultsTableView.topAnchor.constraint(equalTo: searchTextField.bottomAnchor, constant: 20),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

  private func setupTableView() {
    resultsTableView.dataSource = self
    resultsTableView.delegate = self
    resultsTableView.register(UITableViewCell.self, forCellReuseIdentifier: "DestinationCell")
    }

  private func setupTextField() {
    searchTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

  @objc private func textFieldDidChange() {
    guard let searchText = searchTextField.text else { return }
    filterDestinations(for: searchText)
    }

  private func filterDestinations(for searchText: String) {
    if searchText.isEmpty {
      filteredDestinations = allDestinations
        } else {
            filteredDestinations = allDestinations.filter { $0.lowercased().contains(searchText.lowercased()) }
        }
        resultsTableView.reloadData()
    }
}

extension TravelSearchView: UITableViewDataSource, UITableViewDelegate {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredDestinations.count
    }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DestinationCell", for: indexPath)
        cell.textLabel?.text = filteredDestinations[indexPath.row]
        return cell
    }
}

extension UITextField {
  func setPlaceholder(text: String, font: UIFont, color: UIColor) {
    let attributes: [NSAttributedString.Key: Any] = [
          .font: font,
          .foregroundColor: color
        ]
    self.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)
    }
}

#Preview {
  let preview = TravelSearchView()
  return preview
}
