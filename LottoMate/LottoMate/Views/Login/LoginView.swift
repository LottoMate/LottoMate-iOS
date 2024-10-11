//
//  LoginView.swift
//  LottoMate
//
//  Created by Mirae on 10/3/24.
//

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxGesture

class LoginView: UIView {
    fileprivate let rootFlexContainer = UIView()
    let viewModel = LoginViewModel.shared
    let disposeBag = DisposeBag()
    
    let titleLabel = UILabel()
    let titleImage = UIImageView()
    let bodyLabel = UILabel()
    let kakaoLoginButton = UIImageView()
    let naverLoginButton = UIImageView()
    let googleLoginButton = UIImageView()
    let appleLoginButton = UIImageView()
    
    init() {
        super.init(frame: .zero)
        
        signInButtonTapped()
        
        backgroundColor = .white
        
        titleLabel.text = "로또 당첨을 위해\r로또메이트와 함께!"
        titleLabel.numberOfLines = 2
        styleLabel(for: titleLabel, fontStyle: .title2, textColor: .black)
        
        bodyLabel.text = "가장 편한 방법으로 로그인하고\r로또메이트에서 더 많은 행운을 불러오세요."
        bodyLabel.numberOfLines = 2
        styleLabel(for: bodyLabel, fontStyle: .body1, textColor: .gray100)
        
        
        if let image = UIImage(named: "ch_loginView") {
            titleImage.image = image
            titleImage.contentMode = .scaleAspectFit
        }
        
        if let kakaoBtnImage = UIImage(named: "login_Kakao") {
            kakaoLoginButton.image = kakaoBtnImage
            kakaoLoginButton.contentMode = .scaleAspectFit
        }
        if let naverBtnImage = UIImage(named: "login_Naver") {
            naverLoginButton.image = naverBtnImage
            naverLoginButton.contentMode = .scaleAspectFit
        }
        if let googleBtnImage = UIImage(named: "login_Google") {
            googleLoginButton.image = googleBtnImage
            googleLoginButton.contentMode = .scaleAspectFit
        }
        if let appleBtnImage = UIImage(named: "login_Apple") {
            appleLoginButton.image = appleBtnImage
            appleLoginButton.contentMode = .scaleAspectFit
        }
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(titleLabel).marginTop(82)
            flex.addItem(titleImage).width(317).height(200).marginHorizontal(29).marginTop(118)
            flex.addItem(bodyLabel).marginTop(64)
            flex.addItem().direction(.row).gap(20).marginTop(20).marginHorizontal(77.5).define { flex in
                flex.addItem(kakaoLoginButton).size(40)
                flex.addItem(naverLoginButton).size(40)
                flex.addItem(googleLoginButton).size(40)
                flex.addItem(appleLoginButton).size(40)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func signInButtonTapped() {
        googleLoginButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                self.viewModel.googleSignIn()
            })
            .disposed(by: disposeBag)
    }
}

#Preview {
    let view = LoginView()
    return view
}
