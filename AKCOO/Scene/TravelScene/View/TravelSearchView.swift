//
//  TravelSearchView.swift
//  AKCOO
//
//  Created by KIM SEOWOO on 11/9/24.
//

import UIKit

class TravelSearchView: UIViewController {
    
    private let destinationLabel = UILabel().set {
    $0.font = .akFont(.gmarketMedium30)
    $0.textColor = UIColor.akColor(.black)
    $0.text = "어디로 떠나시나요?"
    }
    
    override func viewDidLoad() {
    super.viewDidLoad()
        
    }
}
