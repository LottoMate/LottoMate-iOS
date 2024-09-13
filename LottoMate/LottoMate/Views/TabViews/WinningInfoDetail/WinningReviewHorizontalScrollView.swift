//
//  WinningReviewHorizontalScrollView.swift
//  LottoMate
//
//  Created by Mirae on 9/13/24.
//

import UIKit
import PinLayout
import FlexLayout

class WinningReviewHorizontalScrollView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate let scrollView = UIScrollView()
    
    let sampleReviewCardView = ThumbnailCardView()
    let sampleReviewCardView2 = ThumbnailCardView()
    let sampleReviewCardView3 = ThumbnailCardView()
    let sampleReviewCardView4 = ThumbnailCardView()
    let sampleReviewCardView5 = ThumbnailCardView()
    let sampleReviewCardView6 = ThumbnailCardView()
    
    init() {
        super.init(frame: .zero)
        
        scrollView.showsHorizontalScrollIndicator = false // 스크롤 인디케이터 숨기기
        scrollView.isPagingEnabled = true
        
        scrollView.addSubview(rootFlexContainer)
        addSubview(scrollView)
        
        rootFlexContainer.flex.direction(.row).gap(16).marginTop(10).define { flex in
            flex.addItem(sampleReviewCardView).marginLeft(20)
            flex.addItem(sampleReviewCardView2)
            flex.addItem(sampleReviewCardView3)
            flex.addItem(sampleReviewCardView4)
            flex.addItem(sampleReviewCardView5)
            flex.addItem(sampleReviewCardView6).marginRight(20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // scrollView의 크기를 뷰 전체에 맞춤
        scrollView.pin.all()
        
        // rootFlexContainer의 위치 및 크기 설정
        rootFlexContainer.pin.top().left().bottom() // 세로로는 상하를 고정하고 가로로 확장
        
        // rootFlexContainer 내부 레이아웃 정의 및 레이아웃 적용
        rootFlexContainer.flex.layout(mode: .adjustWidth) // 컨텐츠의 가로 크기를 Flex에 맞춰 조정
        
        // scrollView의 contentSize를 rootFlexContainer의 크기로 설정
        scrollView.contentSize = rootFlexContainer.frame.size
    }
}

#Preview {
    WinningReviewHorizontalScrollView()
}
