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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButtonImage = UIImage(named: "backArrow")
        navBackButton.setImage(backButtonImage, for: .normal)
        navBackButton.tintColor = .white
        navBackButton.frame = CGRect(x: 0, y: 0, width: 10, height: 18)
        
        view.addSubview(rootFlexContainer)
        rootFlexContainer.flex.define { flex in
            flex.addItem(navBackButton).alignSelf(.start).marginLeft(20)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top(view.safeAreaInsets.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
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
