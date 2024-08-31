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
import RxCocoa
import RxRelay
import BottomSheet

class WinningNumbersDetailViewController: UIViewController {
    fileprivate var mainView: WinningInfoDetailView {
        return self.view as! WinningInfoDetailView
    }
    
    fileprivate let rootFlexContainer = UIView()
    let viewModel = LottoMateViewModel.shared
    private let loadingIndicator = UIActivityIndicatorView(style: .large)
    private let disposeBag = DisposeBag()
    
    
    let navBarContainer = UIView()
    /// 네비게이션 아이템 타이틀
    let navTitleLabel = UILabel()
    /// 네비게이션 아이템 뒤로가기 버튼
    let navBackButton = UIButton()
    
    let winningInfoDetailView = WinningInfoDetailView()
    
    override func loadView() {
        view = winningInfoDetailView
        mainView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 뷰를 나타낼때마다 색이 적용되어 opacity가 변경됨... 점점 불투명해짐.
        changeStatusBarBgColor(bgColor: .commonNavBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        bindViewModel()
        
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top(view.safeAreaInsets.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    private func bindViewModel() {
        mainView.setupBindings(viewModel: viewModel)
    }
    
    func bind() {
        viewModel.lottoRoundTapEvent
            .subscribe(onNext: { isTapped in
                guard let tapped = isTapped else { return }
                if tapped {
                    self.showDrawPicker()
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func backButtonTapped() {
        didTapBackButton()
    }
    
    @objc func showDrawPicker() {
        let pickerVC = DrawPickerViewController()
        pickerVC.modalPresentationStyle = .pageSheet
        pickerVC.modalTransitionStyle = .coverVertical
        
        pickerVC.selectedDrawInfo = { selectedInfo in
            print("Selected draw info: \(selectedInfo)")
        }
//        present(pickerVC, animated: true, completion: nil)
        
        present(pickerVC, animated: true) {
            if let sheet = pickerVC.sheetPresentationController {
                sheet.detents = [
                    .custom { context in
                        print("pickerVC.view.frame.height: \(pickerVC.view.frame.height)")
                        return 284.0
                    }
                ]
                sheet.prefersGrabberVisible = false
            }
        }
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
