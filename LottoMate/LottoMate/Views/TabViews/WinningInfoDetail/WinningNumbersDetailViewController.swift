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
        
        // !NO_SERVER
//        viewModel.lottoDrawRoundPickerViewData()
//        viewModel.pensionLotteryDrawRoundPickerViewData()
        
        navTitleLabel.text = "당첨 정보 상세"
        styleLabel(for: navTitleLabel, fontStyle: .headline1, textColor: .primaryGray)
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.tintColor = .black
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
        viewModel.drawRoundTapEvent
            .subscribe(onNext: { isTapped in
                guard let tapped = isTapped else { return }
                if tapped {
                    self.showDrawRoundTest()
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.speetoPageTapEvent
            .subscribe(onNext: { isTapped in
                guard let tapped = isTapped else { return }
                if tapped {
                    self.showDrawRoundTest()
                }
            })
            .disposed(by: disposeBag)
    }
    
    @objc func backButtonTapped() {
        didTapBackButton()
    }
    
    func changeStatusBarBgColor(bgColor: UIColor?) {
        guard let windowScene = UIApplication.shared.connectedScenes.first(where: { $0.activationState == .foregroundActive }) as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tag = 987654 // 고유한 태그 번호 설정
        
        // 기존의 statusBarView가 있는지 확인
        if let existingStatusBarView = window.viewWithTag(tag) {
            // 이미 존재하면 배경색만 업데이트
            existingStatusBarView.backgroundColor = bgColor
        } else {
            // 존재하지 않으면 새로운 statusBarView 생성
            let statusBarManager = windowScene.statusBarManager
            let statusBarFrame = statusBarManager?.statusBarFrame ?? .zero
            
            // 새로운 statusBarView 생성 및 설정
            let statusBarView = UIView(frame: statusBarFrame)
            statusBarView.backgroundColor = bgColor
            statusBarView.tag = tag // 고유 태그 설정
            
            // statusBarView를 윈도우에 추가
            window.addSubview(statusBarView)
        }
    }
    
    func showDrawRoundTest() {
        let viewController = DrawPickerViewController()
        viewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.25)
        
        presentBottomSheet(viewController: viewController, configuration: BottomSheetConfiguration(
            cornerRadius: 32,
            pullBarConfiguration: .hidden,
            shadowConfiguration: .default
        ), canBeDismissed: {
            true
        }, dismissCompletion: {
            // handle bottom sheet dismissal completion
        })
//        let viewController = DrawPickerViewController()
//        let height: CGFloat = 700
//        let bottomSheetViewController = BottomSheetViewController(
//            contentViewController: viewController,
//            defaultHeight: height,
//            cornerRadius: 25,
//            isPannedable: true)
//        
//        self.present(bottomSheetViewController, animated: false, completion: nil)
    }
}

extension WinningNumbersDetailViewController: WinningInfoDetailViewDelegate {
    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
        // 뒤로간 후 다시 돌아올 때 회차 선택 피커뷰 나타남을 방지
        self.viewModel.drawRoundTapEvent.accept(false)
    }
}

#Preview {
    let winningNumbersDetailViewController = WinningNumbersDetailViewController()
    return winningNumbersDetailViewController
}
