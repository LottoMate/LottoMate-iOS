//
//  SpeetoPrizeInfoCardView.swift
//  LottoMate
//
//  Created by Mirae on 8/21/24.
//

import UIKit
import PinLayout
import FlexLayout

enum SpeetoPrizeTier: String {
    case firstPrize = "1등"
    case secondPrize = "2등"
    case thirdPrize = "3등"
    case fourthPrize = "4등"
    case fifthPrize = "5등"
    case sixthPrize = "6등"
    
    var prizeTextColor: UIColor {
        switch self {
        case .firstPrize:
            return .red50Default
        default:
            return .gray_6B6B6B
        }
    }
    var prizeAmount: String {
        switch self {
        case .firstPrize:
            return "10억원"
        case .secondPrize:
            return "1억원"
        default:
            return ""
        }
    }
}


class SpeetoPrizeInfoCardView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    var prizeTier: SpeetoPrizeTier = .firstPrize
    
    /// 스피또 당첨 등수 레이블 (예: 1등)
    let rank = UILabel()
    /// 1등 아이콘 (스피또 아이콘으로 변경 필요)
    private let firstPrizeIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_winnerBadge_lotto")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// 스피또 당첨 금액 레이블 (예: 10억원)
    let prizeMoney = UILabel()
    /// 당첨 상세 정보 컨테이너 (회색 배경)
    let prizeInfoDetailContainer = UIView()
    /// 판매점 타이틀 레이블
    let storeNameLabel = UILabel()
    /// 판매점 이름 레이블
    var storeNameValueLabel = UILabel()
    /// 당첨 회차 레이블
    let winningRoundLabel = UILabel()
    /// 당첨자 인터뷰 버튼 레이블
    var winnerInterViewTextLabel = UILabel()
    /// 당첨자 인터뷰 버튼 right arrow
    var winnerInterViewArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_arrow_right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// 지급일 레이블
    var prizePaymentDateLabel = UILabel()
    
    /// 당첨 정보 상세 컨테이너들을 담을 컨테이너
    var prizeInfoDetailContainers = UIView()
    
    init(prizeTier: SpeetoPrizeTier, prizePerWinnerValue: Int? = nil) {
        super.init(frame: .zero)
        self.prizeTier = prizeTier
        configureCardView(for: rootFlexContainer)
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 8, opacity: 0.1)
        
        rank.text = prizeTier.rawValue
        styleLabel(for: rank, fontStyle: .headline2, textColor: prizeTier.prizeTextColor)
        
        firstPrizeIcon.frame = CGRect(x: 0, y: 0, width: 24, height: 24)
        
        prizeMoney.text = prizeTier.prizeAmount
        styleLabel(for: prizeMoney, fontStyle: .title3, textColor: .black)
        
        // MARK: FlexLayout
        rootFlexContainer.flex.direction(.column).padding(20).define { flex in
            flex.addItem().direction(.row).define { flex in
                if prizeTier == .firstPrize {
                    flex.addItem(firstPrizeIcon).marginRight(8)
                }
                flex.addItem(rank).alignSelf(.start)
            }
            flex.addItem(prizeMoney).alignSelf(.start).marginBottom(12)
            // 정보 컨테이너 (회색 배경)
            flex.addItem().direction(.column).define { flex in
                SampleSpeetoData.sampleData2000[prizeTier]?.forEach({ winningInfo in
                    let view = SpeetoCardViewDetailContainer(winningInfo: winningInfo)
                    flex.addItem(view).marginBottom(10)
                })
            }
        }
        addSubview(rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

#Preview {
    let view = SpeetoPrizeInfoCardView(prizeTier: .secondPrize)
    return view
}
