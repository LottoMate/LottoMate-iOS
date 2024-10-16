//
//  ImageContentViewController.swift
//  LottoMate
//
//  Created by Mirae on 9/13/24.
//

import UIKit
import FlexLayout
import PinLayout
import RxSwift
import RxGesture

// 이미지 콘텐츠를 표시하는 뷰 컨트롤러
class ImageContentViewController: UIViewController {
    let viewModel = LottoMateViewModel.shared
    fileprivate let rootFlexContainer = UIView()
    private let disposeBag = DisposeBag()
    
    var imageView: UIImageView!
    var imageName: String = ""
    var pageIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 이미지 뷰 설정
        imageView = UIImageView()
        imageView.image = UIImage(named: imageName)
        imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.33)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        // 이미지를 탭하여 전체화면으로 보기
        imageView.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { _ in
                // view model로 해당 이미지 정보와
                self.viewModel.winningReviewFullSizeImgName.onNext(self.imageName)
            })
            .disposed(by: disposeBag)
        
        view.addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(imageView)
                .height(UIScreen.main.bounds.width / 1.33)  // 고정된 비율로 높이 설정
                .width(UIScreen.main.bounds.width)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.all()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

#Preview {
    var imageContentVC = ImageContentViewController()
    imageContentVC.imageName = "winning_review_sample_2"
    return imageContentVC
}
