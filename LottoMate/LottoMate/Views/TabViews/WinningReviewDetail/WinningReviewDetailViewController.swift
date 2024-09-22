//
//  WinningReviewDetailViewController.swift
//  LottoMate
//
//  Created by Mirae on 9/12/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift

class WinningReviewDetailViewController: UIViewController {
    fileprivate var mainView: WinningReviewDetailView {
        return self.view as! WinningReviewDetailView
    }
    
    fileprivate let rootFlexContainer = UIView()
    
    let viewModel = LottoMateViewModel.shared
    
    private let disposeBag = DisposeBag()
    
    let navBarContainer = UIView()
    /// 네비게이션 아이템 타이틀
    let navTitleLabel = UILabel()
    /// 네비게이션 아이템 뒤로가기 버튼
    let navBackButton = UIButton()
    
    let winningReviewDetailView = WinningReviewDetailView()
    
    override func loadView() {
        view = winningReviewDetailView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        changeStatusBarBgColor(bgColor: .commonNavBar)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.tintColor = .black
        navBackButton.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        navBackButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        showTappedImage()
        
        view.addSubview(rootFlexContainer)
        rootFlexContainer.flex.paddingVertical(19).define { flex in
            flex.addItem(navBackButton).alignSelf(.start).marginLeft(20)
        }
        .backgroundColor(.commonNavBar)
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
    
    func showTappedImage() {
        viewModel.winningReviewFullSizeImgName
            .subscribe(onNext: { name in
                if name != "" {
                    self.changeStatusBarBgColor(bgColor: .clear)
                    self.showFullscreenImage(named: "\(name)")
                }
            })
            .disposed(by: disposeBag)
    }
    
    func showFullscreenImage(named name: String) {
        // 투명한 배경 뷰 추가 (터치 이벤트 차단용)
        let dimmingView = UIView(frame: self.view.bounds)
        dimmingView.backgroundColor = .dimFullScreenImageBackground
        dimmingView.isUserInteractionEnabled = true // 다른 터치를 막기 위해 사용
        
        // 전체 화면 이미지 뷰 설정
        let fullscreenImageView = UIImageView(frame: self.view.bounds)
        fullscreenImageView.contentMode = .scaleAspectFit
        fullscreenImageView.image = UIImage(named: name)
        fullscreenImageView.isUserInteractionEnabled = true // 이미지 뷰도 터치 이벤트를 받을 수 있게 설정
        
        // closeButton 이미지 생성
        if let closeIcon = UIImage(named: "icon_X")?.withRenderingMode(.alwaysTemplate) {
            let closeButton = UIImageView(image: closeIcon)
            closeButton.tintColor = UIColor.white.withAlphaComponent(0.6)
            closeButton.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
            closeButton.isUserInteractionEnabled = true // 버튼처럼 동작하도록 설정
            
            // UIWindowScene을 통해 window 접근
            if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
               let window = windowScene.windows.first {
                
                // status bar height 가져오기
                let statusBarHeight = windowScene.statusBarManager?.statusBarFrame.height ?? 0
                
                // closeButton을 status bar height + 16 아래로 배치
                let closeButtonX = window.frame.width - 24 - 20 // 오른쪽에서 20px 띄움
                let closeButtonY = statusBarHeight + 16 // status bar 아래로 16pt 띄움
                
                closeButton.frame.origin = CGPoint(x: closeButtonX, y: closeButtonY)
                
                // closeButton에 탭 제스처 추가 (전체 화면 이미지 제거 기능)
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissFullscreenImage))
                closeButton.addGestureRecognizer(tapGesture)
            }
            
            // closeButton을 fullscreenImageView에 추가
            fullscreenImageView.addSubview(closeButton)
        }
        
        // dimmingView에 fullscreenImageView를 추가
        dimmingView.addSubview(fullscreenImageView)
        
        // dimmingView를 현재 뷰에 추가
        self.view.addSubview(dimmingView)
    }
    
    @objc func dismissFullscreenImage() {
        if let dimmingView = self.view.subviews.first(where: { $0.backgroundColor == .dimFullScreenImageBackground }) {
            UIView.animate(withDuration: 0.3, animations: {
                dimmingView.alpha = 0
            }) { _ in
                dimmingView.removeFromSuperview()
                self.changeStatusBarBgColor(bgColor: .commonNavBar)
                self.viewModel.winningReviewFullSizeImgName.onNext("")
            }
        }
    }
}

#Preview {
    let view = WinningReviewDetailViewController()
    return view
}
