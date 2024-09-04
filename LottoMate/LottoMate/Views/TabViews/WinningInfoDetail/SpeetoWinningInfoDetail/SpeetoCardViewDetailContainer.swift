//
//  SpeetoCardViewDetailContainer.swift
//  LottoMate
//
//  Created by Mirae on 8/21/24.
//

import UIKit
import PinLayout
import FlexLayout

class SpeetoCardViewDetailContainer: UIView {
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
    
    fileprivate let rootFlexContainer = UIView()
    
    init(winningInfo: SampleSpeetoStoreModel) {
        super.init(frame: .zero)
        
        setupDetailInfoContainer(for: winningInfo)
        
        rootFlexContainer.flex.direction(.column).paddingVertical(16).paddingHorizontal(20).define { flex in
            // row 1
            flex.addItem().direction(.row).justifyContent(.spaceBetween).grow(1).define { flex in
                flex.addItem().direction(.row).define { flex in
                    flex.addItem(storeNameLabel).marginRight(4) // 판매점
                    flex.addItem(storeNameValueLabel) // 야단법석
                }
                // 1등일때만 당첨자 인터뷰 이동 버튼 나타남
                if winningInfo.prizeTier == .firstPrize {
                    flex.addItem().direction(.row).define { flex in
                        flex.addItem(winnerInterViewTextLabel).marginRight(4) // 당첨자 인터뷰
                        flex.addItem(winnerInterViewArrow) // 당첨자 인터뷰 arrow icon
                    }
                }
            }
            
            flex.addItem().direction(.row).marginTop(8).define { flex in
                flex.addItem(winningRoundLabel).marginRight(10)
                flex.addItem(prizePaymentDateLabel) // 지급 날짜
            }
        }
        
        addSubview(rootFlexContainer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func setupDetailInfoContainer(for winningInfo: SampleSpeetoStoreModel) {
        rootFlexContainer.backgroundColor = .gray_F9F9F9
        rootFlexContainer.layer.cornerRadius = 8
        
        storeNameLabel.text = "판매점"
        styleLabel(for: storeNameLabel, fontStyle: .label2, textColor: .gray100)
        
        winnerInterViewTextLabel.text = "당첨자 인터뷰"
        styleLabel(for: winnerInterViewTextLabel, fontStyle: .caption, textColor: .gray100)
        winnerInterViewArrow.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
        
        winningRoundLabel.text = "\(winningInfo.round)회차"
        
        styleLabel(for: winningRoundLabel, fontStyle: .label2, textColor: .gray100)
        
        storeNameValueLabel.text = "\(winningInfo.storeName)"
        storeNameValueLabel.numberOfLines = 1
        storeNameValueLabel.lineBreakMode = .byTruncatingTail // ... 으로 줄어들지 않음. 확인 필요.
        styleLabel(for: storeNameValueLabel, fontStyle: .headline2, textColor: .black)
        
        prizePaymentDateLabel.text = "\(winningInfo.prizePaymentDate.reformatDate) 지급"
        styleLabel(for: prizePaymentDateLabel, fontStyle: .label2, textColor: .gray100)
    }
}

#Preview {
    let view = SpeetoCardViewDetailContainer(winningInfo: SampleSpeetoStoreModel(prizeTier: .secondPrize, storeName: "샘플상호명", round: 32, prizePaymentDate: "2024.06.24"))
    return view
}
