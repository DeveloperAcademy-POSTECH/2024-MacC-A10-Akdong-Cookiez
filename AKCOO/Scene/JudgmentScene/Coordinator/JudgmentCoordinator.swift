//
//  JudgmentCoordinator.swift
//  AKCOO
//
//  Created by 박혜운 on 11/14/24.
//

import UIKit

protocol JudgmentCoordinator: Coordinator {
  func startJudgment(presenting: UIViewController, userQuestion: UserQuestion)
  func startEditPaper(presenting: JudgmentEditViewControllerDelegate, paperModel: PaperModel, selectedCategory: String, userAmount: String)
  func completedEditPaper(editViewController: JudgmentEditViewController)
}
