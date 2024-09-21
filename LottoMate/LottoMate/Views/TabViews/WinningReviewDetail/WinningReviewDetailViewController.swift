//
//  WinningReviewDetailViewController.swift
//  LottoMate
//
//  Created by Mirae on 9/12/24.
//

import UIKit
import FlexLayout
import PinLayout

class WinningReviewDetailViewController: UIViewController {
    fileprivate var mainView: WinningReviewDetailView {
        return self.view as! WinningReviewDetailView
    }
    
    fileprivate let rootFlexContainer = UIView()

    let viewModel = LottoMateViewModel.shared
    
    let navBarContainer = UIView()
    /// 네비게이션 아이템 타이틀
    let navTitleLabel = UILabel()
    /// 네비게이션 아이템 뒤로가기 버튼
    let navBackButton = UIButton()
    
    let winningReviewDetailView = WinningReviewDetailView()
    
    override func loadView() {
        view = winningReviewDetailView
        mainView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 뷰를 나타낼때마다 색이 적용되어 opacity가 변경됨... 점점 불투명해짐.
        changeStatusBarBgColor(bgColor: .commonNavBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.tintColor = .black
        navBackButton.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        navBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        print("device? \(UIDevice.current.name)")
        
        view.addSubview(rootFlexContainer)
        rootFlexContainer.flex.paddingVertical(19).define { flex in
            flex.addItem(navBackButton).alignSelf(.start).marginLeft(20)
        }
        .backgroundColor(.white.withAlphaComponent(0.8))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 상태바의 높이를 가져오기 위한 설정
        var statusBarHeight: CGFloat = 0.0
        
        if let windowScene = view.window?.windowScene {
            statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
        }
        
        // rootFlexContainer를 상태바 바로 아래에 배치
        rootFlexContainer.pin
            .top(statusBarHeight)  // 상태바 바로 아래에 배치
            .horizontally()         // 좌우 여백은 기본으로 적용
        rootFlexContainer.flex.layout(mode: .adjustHeight) // 높이는 flex로 자동 조정
    }
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
}

extension WinningReviewDetailViewController: WinningReviewDetailViewDelegate {
    func didScrollDown() {
        navBackButton.isHidden = true
    }
    func didScrollUp() {
        navBackButton.isHidden = false
    }
    
}

#Preview {
    let view = WinningReviewDetailViewController()
    return view
}
