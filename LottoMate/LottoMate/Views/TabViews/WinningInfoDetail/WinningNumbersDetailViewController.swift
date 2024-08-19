//
//  WinningNumbersDetailViewController.swift
//  LottoMate
//
//  Created by Mirae on 7/30/24.
//  당첨 번호 상세 ViewController

import UIKit
import FlexLayout
import PinLayout
import RxSwift

class WinningNumbersDetailViewController: UIViewController {
    fileprivate var mainView: WinningInfoDetailView {
        return self.view as! WinningInfoDetailView
    }
    
    private let viewModel = LottoMateViewModel()
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        let winningInfoDetailView = WinningInfoDetailView(viewModel: viewModel)
        view = winningInfoDetailView
        mainView.delegate = self
        
//        setupLoadingIndicator()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleLabel(for: mainView.lotteryDrawRound, fontStyle: .headline1, textColor: .primaryGray)
        
        // 회차별 로또 정보 가져오기
        viewModel.fetchLottoResult(round: 1126)
        
        setupBindings()
    }
    
    private func setupLoadingIndicator() {
        view.addSubview(loadingIndicator)
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
    
    private func setupBindings() {
//        viewModel.isLoading
//            .bind(to: loadingIndicator.rx.isAnimating)
//            .disposed(by: disposeBag)
        
        // Accessing mainView's properties
        viewModel.lottoResult
            .map { result in
                let text = "\(result?.lottoResult.lottoRndNum ?? 0)회"
                return NSAttributedString(string: text, attributes: Typography.headline1.attributes())
            }
            .bind(to: mainView.lotteryDrawRound.rx.attributedText)
            .disposed(by: disposeBag)
        
//        viewModel.isLoading
//            .map { !$0 }
//            .bind(to: mainView.rx.isHidden)
//            .disposed(by: disposeBag)
    }
}

extension WinningNumbersDetailViewController: WinningInfoDetailViewDelegate {
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
