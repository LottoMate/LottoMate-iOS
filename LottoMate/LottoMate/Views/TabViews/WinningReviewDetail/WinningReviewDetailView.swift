//
//  WinningReviewDetailView.swift
//  LottoMate
//
//  Created by Mirae on 9/12/24.
//

import UIKit
import PinLayout
import FlexLayout

protocol WinningReviewDetailViewDelegate: AnyObject {
    func didScrollDown()
    func didScrollUp()
}

class WinningReviewDetailView: UIView, UIScrollViewDelegate {
    fileprivate let scrollView = UIScrollView()
    fileprivate let rootFlexContainer = UIView()
    
    weak var delegate: WinningReviewDetailViewDelegate?
    
    /// 당첨 회차 레이블
    let drawRoundLabel = UILabel()
    let dotLabel = UILabel()
    /// 당첨 복권 타입, 등수, 당첨금 정보 레이블
    let winningLotteryInfoLabel = UILabel()
    /// 당첨 후기 제목 레이블
    let winningReviewDetailTitleLabel = UILabel()
    /// 당첨 후기 인터뷰 날짜 레이블
    let interviewDate = UILabel()
    /// 당첨 후기 작성 날짜 레이블
    let createdDate = UILabel()
    
    // 인터뷰 데이터의 형태에 따라 질문, 답변에 적용된 스타일은 달라질 에정입니다.
    // 일단 디자인 된 형태로 작성하기 위해 임시 레이블을 사용합니다.
    let questionLabel = UILabel()
    let answerLabel = UILabel()
    
    let questionLabel2 = UILabel()
    let answerLabel2 = UILabel()
    
    let questionLabel3 = UILabel()
    let answerLabel3 = UILabel()
    
    let questionLabel4 = UILabel()
    let answerLabel4 = UILabel()
    
    /// 안내 레이블 - 오늘 본 글은 내일 다시 확인할 수 있어요.
    let noticeLabel = UILabel()
    /// 원문 보러 가기 버튼
    let goToOriginalReview = UIButton(type: .system)
    /// 다른 당첨 후기 리스트 타이틀
    let otherReviewsTitle = UILabel()
    /// 다른 당첨 후기 리스트 타이틀 아래 나타나는 설명 레이블
    let otherReviewsSecondary = UILabel()
    
    let horizontalReviewCards = WinningReviewHorizontalScrollView()
    
    /// 임시 배너
    let banner = BannerView(bannerBackgroundColor: .yellow5, bannerImageName: "img_banner_coins", titleText: "행운의 1등 로또\r어디서 샀을까?", bodyText: "당첨 판매점 보러가기")
    
    let imagePageView = ImagePageViewController()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let topInset = window.safeAreaInsets.top
            scrollView.contentInset.top = -topInset
        }
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        
        setLabels()
        setButtons()

        scrollView.addSubview(rootFlexContainer)
        addSubview(scrollView)
        
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(imagePageView.view)
            // 텍스트 부분
            flex.addItem().direction(.column).paddingHorizontal(20).paddingTop(28).paddingBottom(24).define { flex in
                flex.addItem().direction(.row).gap(4).define { flex in
                    flex.addItem(drawRoundLabel)
                    flex.addItem(dotLabel)
                    flex.addItem(winningLotteryInfoLabel)
                }
                
                flex.addItem(winningReviewDetailTitleLabel).marginRight(77).marginBottom(4)
                
                flex.addItem().direction(.row).gap(8).alignItems(.center).marginBottom(24).define { flex in
                    flex.addItem(interviewDate)
                    flex.addItem().width(1).height(10).backgroundColor(.gray80)
                    flex.addItem(createdDate)
                }
                
                flex.addItem().direction(.column).marginBottom(16).define { flex in
                    flex.addItem(questionLabel)
                    flex.addItem(answerLabel).marginBottom(28)
                    
                    flex.addItem(questionLabel2)
                    flex.addItem(answerLabel2).marginBottom(28)
                    
                    flex.addItem(questionLabel3)
                    flex.addItem(answerLabel3).marginBottom(28)
                    
                    flex.addItem(questionLabel4)
                    flex.addItem(answerLabel4)
                }
                flex.addItem().direction(.row).justifyContent(.spaceBetween).define { flex in
                    flex.addItem(noticeLabel)
                    flex.addItem(goToOriginalReview)
                }
            }
            // 구분선
            flex.addItem().height(10).backgroundColor(.gray20).marginBottom(24)
            
            flex.addItem().direction(.column).define { flex in
                flex.addItem(otherReviewsTitle).alignSelf(.start).paddingHorizontal(20)
                flex.addItem(otherReviewsSecondary).alignSelf(.start).paddingHorizontal(20).marginBottom(10)
                flex.addItem(horizontalReviewCards).width(100%).height(220).marginBottom(18)
                flex.addItem(banner).marginHorizontal(20).marginBottom(58)
            }
        }
    }
    
    func setLabels() {
        drawRoundLabel.text = "NNN회차"
        styleLabel(for: drawRoundLabel, fontStyle: .label2, textColor: .gray120)
        dotLabel.text = "•"
        styleLabel(for: dotLabel, fontStyle: .caption, textColor: .gray120)
        winningLotteryInfoLabel.text = "연금복권 1등 NN억"
        styleLabel(for: winningLotteryInfoLabel, fontStyle: .label2, textColor: .gray120)
        
        winningReviewDetailTitleLabel.numberOfLines = 2
        winningReviewDetailTitleLabel.lineBreakMode = .byWordWrapping
        winningReviewDetailTitleLabel.text = "사회 초년생 시절부터 꾸준히 구매해서 1등 당첨!"
        styleLabel(for: winningReviewDetailTitleLabel, fontStyle: .title3, textColor: .black, alignment: .left)
        
        interviewDate.text = "인터뷰 2024.06.29"
        styleLabel(for: interviewDate, fontStyle: .caption, textColor: .gray80)
        createdDate.text = "작성 2024.07.01"
        styleLabel(for: createdDate, fontStyle: .caption, textColor: .gray80)
        
        questionLabel.numberOfLines = 0
        questionLabel2.numberOfLines = 0
        questionLabel3.numberOfLines = 0
        questionLabel4.numberOfLines = 0
        
        answerLabel.numberOfLines = 0
        answerLabel2.numberOfLines = 0
        answerLabel3.numberOfLines = 0
        answerLabel4.numberOfLines = 0
        
        questionLabel.text = "Q. 당첨되신 걸 어떻게 알게 되셨고, 또 알았을 때 기분이 어떠셨나요?"
        questionLabel2.text = "Q. 1등 당첨된 것을 알고 가장 먼저 든 생각 혹은 가장 먼저 생각난 사람은?"
        questionLabel3.text = "Q. 평소에 어떤 복권을 자주 구매하시나요?"
        questionLabel4.text = "Q. 당첨금은 어디에 사용하실 계획인가요?"
        
        answerLabel.text = "복권 당첨 후기 이벤트 멘트 작성 예정입니다. 질문에 대한 답변입니다. 나도 당첨되고 싶다. 저희 모두 당첨되게 해주세요. 신축 빌라 갖고 싶당."
        answerLabel2.text = "복권 당첨 후기 이벤트 멘트 작성 예정입니다. 질문에 대한 답변입니다. 나도 당첨되고 싶다. 저희 모두 당첨되게 해주세요. 신축 빌라 갖고 싶당."
        answerLabel3.text = "복권 당첨 후기 이벤트 멘트 작성 예정입니다. 질문에 대한 답변입니다. 나도 당첨되고 싶다. 저희 모두 당첨되게 해주세요. 신축 빌라 갖고 싶당."
        answerLabel4.text = "복권 당첨 후기 이벤트 멘트 작성 예정입니다. 질문에 대한 답변입니다. 나도 당첨되고 싶다. 저희 모두 당첨되게 해주세요. 신축 빌라 갖고 싶당."
        
        styleLabel(for: questionLabel, fontStyle: .headline2, textColor: .black, alignment: .left)
        styleLabel(for: questionLabel2, fontStyle: .headline2, textColor: .black, alignment: .left)
        styleLabel(for: questionLabel3, fontStyle: .headline2, textColor: .black, alignment: .left)
        styleLabel(for: questionLabel4, fontStyle: .headline2, textColor: .black, alignment: .left)
        
        styleLabel(for: answerLabel, fontStyle: .body1, textColor: .black, alignment: .left)
        styleLabel(for: answerLabel2, fontStyle: .body1, textColor: .black, alignment: .left)
        styleLabel(for: answerLabel3, fontStyle: .body1, textColor: .black, alignment: .left)
        styleLabel(for: answerLabel4, fontStyle: .body1, textColor: .black, alignment: .left)
        
        noticeLabel.text = "오늘 본 글은 내일 다시 확인할 수 있어요."
        styleLabel(for: noticeLabel, fontStyle: .caption, textColor: .gray80)
        
        otherReviewsTitle.text = "로또 당첨자 후기"
        styleLabel(for: otherReviewsTitle, fontStyle: .headline1, textColor: .gray120)
        otherReviewsSecondary.text = "역대 로또 당첨자들의 생생한 후기예요."
        styleLabel(for: otherReviewsSecondary, fontStyle: .label2, textColor: .gray80)
    }
    
    func setButtons() {
        let attributedTitle = NSAttributedString(string: "원문 보러 가기", attributes: Typography.caption.attributes())
        goToOriginalReview.setAttributedTitle(attributedTitle, for: .normal)
        if let image = UIImage(named: "icon_arrow_right_in_button") {
            let resizedImage = resizeImage(image: image, targetSize: CGSizeMake(14.0, 14.0))
            goToOriginalReview.setImage(resizedImage, for: .normal)
        }
        goToOriginalReview.tintColor = .gray100
        goToOriginalReview.semanticContentAttribute = .forceRightToLeft
        goToOriginalReview.imageEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: -2)
        goToOriginalReview.titleEdgeInsets = UIEdgeInsets(top: 0, left: -2, bottom: 0, right: 2)
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage? {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(origin: .zero, size: newSize)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.top().bottom().left().right()
        rootFlexContainer.pin.top().left().right()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        scrollView.contentSize = rootFlexContainer.frame.size
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
        
        let actualPosition = scrollView.panGestureRecognizer.translation(in: scrollView.superview)
       
        if (actualPosition.y > 0) {
            // Dragging down
            
            UIView.animate(withDuration: 3, animations: {
                // Hide navBackButton
                self.delegate?.didScrollUp()
            })
            
        } else {
            // Dragging up
            
            UIView.animate(withDuration: 3, animations: {
                //Change the color of view
                self.delegate?.didScrollDown()
            })
        }
    }
}

#Preview {
    let view = WinningReviewDetailView()
    return view
}
