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
        let winningNumbersView = WinningNumbersDetailView()
        view = winningNumbersView
        
        mainView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    
    @objc func showDrawPicker() {
        let pickerVC = DrawPickerViewController()
        pickerVC.modalPresentationStyle = .pageSheet
        pickerVC.modalTransitionStyle = .coverVertical
        
        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return 200 // Custom height in points
                }
            ]
            sheet.prefersGrabberVisible = true
        }
        
        pickerVC.selectedDrawInfo = { selectedInfo in
            print("Selected draw info: \(selectedInfo)")
        }
        
        present(pickerVC, animated: true, completion: nil)
    }
}

extension WinningNumbersDetailViewController: WinningNumbersDetailViewDelegate {
    func didTapDrawView() {
        showDrawPicker()
    }
    
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
}

#Preview {
    let winningNumbersDetailViewController = WinningNumbersDetailViewController()
    return winningNumbersDetailViewController
}
