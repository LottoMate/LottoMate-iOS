//
//  WinningNumbersDetailViewController.swift
//  LottoMate
//
//  Created by Mirae on 7/30/24.
//  당첨 번호 상세 ViewController

import UIKit
import FlexLayout
import PinLayout

class WinningNumbersDetailViewController: UIViewController {
    fileprivate var mainView: WinningNumbersDetailView {
        return self.view as! WinningNumbersDetailView
    }
    
    override func loadView() {
        view = WinningNumbersDetailView()
        mainView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let winningNumbersDetailView = view as? WinningNumbersDetailView {
//            navigationItem.titleView = winningNumbersDetailView.titleLabel
//            navigationItem.leftBarButtonItem = winningNumbersDetailView.backButton
//        }
    }
}

extension WinningNumbersDetailViewController: WinningNumbersDetailViewDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    let winningNumbersDetailViewController = WinningNumbersDetailViewController()
    return winningNumbersDetailViewController
}
