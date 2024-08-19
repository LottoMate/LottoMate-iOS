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
        let winningInfoDetailView = WinningInfoDetailView()
        view = winningInfoDetailView
        mainView.delegate = self
    }
    
    fileprivate let rootFlexContainer = UIView()
    
    let navBarContainer = UIView()
    /// 네비게이션 아이템 타이틀
    let navTitleLabel = UILabel()
    /// 네비게이션 아이템 뒤로가기 버튼
    let navBackButton = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 네비바에 적용한 컬러와 살짝 달라서 확인 필요
        changeStatusBarBgColor(bgColor: .commonNavBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navTitleLabel.text = "당첨 정보 상세"
        styleLabel(for: navTitleLabel, fontStyle: .headline1, textColor: .primaryGray)
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        navBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(navBarContainer).direction(.row).justifyContent(.center).paddingHorizontal(19).paddingVertical(14).define { navBar in
                navBar.addItem(navBackButton)
                navBar.addItem(navTitleLabel).grow(1).position(.relative).right(8)
            }
            .backgroundColor(.commonNavBar)
        }
        
        view.addSubview(rootFlexContainer)
        
        // 회차별 로또 정보 가져오기
        viewModel.fetchLottoResult(round: 1126)
        
        setupBindings()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top(view.safeAreaInsets.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    @objc func backButtonTapped() {
        didTapBackButton()
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
        viewModel.lottoResult
            .map { result in
                let text = "\(result?.lottoResult.lottoRndNum ?? 0)회"
                return NSAttributedString(string: text, attributes: Typography.headline1.attributes())
            }
            .bind(to: mainView.lotteryDrawRound.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
           if #available(iOS 13.0, *) {
               let window = UIApplication.shared.windows.first
               let statusBarManager = window?.windowScene?.statusBarManager
               
               let statusBarView = UIView(frame: statusBarManager?.statusBarFrame ?? .zero)
               statusBarView.backgroundColor = bgColor
               
               window?.addSubview(statusBarView)
               
           } else {
               let statusBarView = UIApplication.shared.value(forKey: "statusBar") as? UIView
               statusBarView?.backgroundColor = bgColor
           }
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
