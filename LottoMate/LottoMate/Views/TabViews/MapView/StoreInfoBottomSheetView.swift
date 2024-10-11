//
//  StoreInfoBottomSheetView.swift
//  LottoMate
//
//  Created by Mirae on 10/7/24.
//

import UIKit
import PinLayout
import FlexLayout

class StoreInfoBottomSheetView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    let lottoTypeTag = UILabel()
    let pensionLotteryTypeTag = UILabel()
    let speetoTypeTag = UILabel()
    
    let storeName = UILabel()
    let storeDistance = UILabel()
    
    let likeIcon = UIImageView()
    let likeCount = UILabel()
    
    let placeIcon = UIImageView()
    let copyIcon = UIImageView()
    let callIcon = UIImageView()
    
    let addressLabel = UILabel()
    let phoneNumberLabel = UILabel()
    
    let lottoIcon = UIImageView()
    let pensionLotteryIcon = UIImageView()
    let speetoIcon = UIImageView()
    
    let lottoLabel = UILabel()
    let lottoWinningCount = UILabel()
    
    let pensionLotteryLabel = UILabel()
    let pensionLotteryWinningCount = UILabel()
    
    let speetoLabel = UILabel()
    let speetoWinningCount = UILabel()
    
    let arrowDownIcon = UIImageView()
    
    let sampleData = StoreInfoSampleData.drwtList
    
    let winningTags = StoreInfoWinningTagHorizontalScrollView()
    let noWinningHistoryCharacter = UIImageView()
    let noWinningHistoryLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        
        lottoTypeTag.text = "로또"
        styleLabel(for: lottoTypeTag, fontStyle: .caption1, textColor: .green70)
        lottoTypeTag.clipsToBounds = true
        
        pensionLotteryTypeTag.text = "연금복권"
        styleLabel(for: pensionLotteryTypeTag, fontStyle: .caption1, textColor: .blue50Default)
        pensionLotteryTypeTag.clipsToBounds = true
        
        speetoTypeTag.text = "스피또"
        styleLabel(for: speetoTypeTag, fontStyle: .caption1, textColor: .peach50Default)
        speetoTypeTag.clipsToBounds = true
        
        storeName.text = "로또복권판매점 복권명당박정희로점"
        styleLabel(for: storeName, fontStyle: .headline1, textColor: .black)
        
        storeDistance.text = "1.6km"
        styleLabel(for: storeDistance, fontStyle: .caption1, textColor: .gray80)
        
        if let likeIconImage = UIImage(named: "icon_like") {
            likeIcon.image = likeIconImage
            likeIcon.contentMode = .scaleAspectFit
        }
        
        likeCount.text = "9,999"
        styleLabel(for: likeCount, fontStyle: .caption2, textColor: .gray80)
        
        if let placeIconImage = UIImage(named: "icon_place") {
            placeIcon.image = placeIconImage
            placeIcon.contentMode = .scaleAspectFit
        }
        if let copyIconImage = UIImage(named: "icon_copy") {
            copyIcon.image = copyIconImage
            copyIcon.contentMode = .scaleAspectFit
        }
        if let callIconImage = UIImage(named: "icon_call") {
            callIcon.image = callIconImage
            callIcon.contentMode = .scaleAspectFit
        }
        
        addressLabel.text = "서울 강남구 봉은사로74길 13 101호"
        styleLabel(for: addressLabel, fontStyle: .label2, textColor: .gray100)
        
        phoneNumberLabel.text = "02-123-4567"
        styleLabel(for: phoneNumberLabel, fontStyle: .label2, textColor: .gray100)
        
        if let lottoIconImage = UIImage(named: "icon_lotto") {
            lottoIcon.image = lottoIconImage
            lottoIcon.contentMode = .scaleAspectFit
        }
        if let pensionLotteryIconImage = UIImage(named: "icon_pensionLottery") {
            pensionLotteryIcon.image = pensionLotteryIconImage
            pensionLotteryIcon.contentMode = .scaleAspectFit
        }
        if let speetoIconImage = UIImage(named: "icon_speeto") {
            speetoIcon.image = speetoIconImage
            speetoIcon.contentMode = .scaleAspectFit
        }
        
        lottoLabel.text = "로또"
        styleLabel(for: lottoLabel, fontStyle: .caption1, textColor: .black)
        
        pensionLotteryLabel.text = "연금복권"
        styleLabel(for: pensionLotteryLabel, fontStyle: .caption1, textColor: .black)
        
        speetoLabel.text = "스피또"
        styleLabel(for: speetoLabel, fontStyle: .caption1, textColor: .black)
        
        lottoWinningCount.text = "12회"
        styleLabel(for: lottoWinningCount, fontStyle: .caption1, textColor: .red50Default)
        
        pensionLotteryWinningCount.text = "9회"
        styleLabel(for: pensionLotteryWinningCount, fontStyle: .caption1, textColor: .red50Default)
        
        speetoWinningCount.text = "4회"
        styleLabel(for: speetoWinningCount, fontStyle: .caption1, textColor: .red50Default)
        
        if let arrowDownIconImage = UIImage(named: "icon_arrow_down") {
            arrowDownIcon.image = arrowDownIconImage
            arrowDownIcon.contentMode = .scaleAspectFit
        }
        
        if let characterImage = UIImage(named: "ch_noWinningHistoryView") {
            noWinningHistoryCharacter.image = characterImage
            noWinningHistoryCharacter.contentMode = .scaleAspectFit
        }
        
        noWinningHistoryLabel.text = "아직 당첨 이력이 없는 판매점입니다."
        styleLabel(for: noWinningHistoryLabel, fontStyle: .body2, textColor: .gray100)
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingTop(12).define { flex in
            // handle
            flex.addItem().width(40).height(4).backgroundColor(.gray30).cornerRadius(2).alignSelf(.center)
            
            flex.addItem().direction(.row).gap(4).paddingLeft(20).marginTop(20).define { flex in
                flex.addItem(lottoTypeTag)
                    .width(37)
                    .height(22)
                    .backgroundColor(.green5)
                    .cornerRadius(4)
                flex.addItem(pensionLotteryTypeTag)
                    .width(56)
                    .height(22)
                    .backgroundColor(.blue5)
                    .cornerRadius(4)
                flex.addItem(speetoTypeTag)
                    .width(46)
                    .height(22)
                    .cornerRadius(4)
                    .backgroundColor(.peach5)
            }
            flex.addItem().direction(.row).marginTop(8).paddingLeft(20).justifyContent(.spaceBetween).alignItems(.start).define { flex in
                flex.addItem().gap(8).direction(.row).define { flex in
                    flex.addItem(storeName)
                    flex.addItem(storeDistance).alignSelf(.end).marginBottom(3)
                }
                flex.addItem().direction(.column).paddingRight(20).define { flex in
                    flex.addItem(likeIcon).size(24)
                    flex.addItem(likeCount)
                }
            }
            flex.addItem().direction(.row).gap(4).paddingLeft(20).alignItems(.center).define { flex in
                flex.addItem(placeIcon).size(12)
                flex.addItem(addressLabel)
                flex.addItem(copyIcon).size(12)
            }
            flex.addItem().direction(.row).gap(4).paddingLeft(20).alignItems(.center).marginTop(2).define { flex in
                flex.addItem(callIcon).size(12)
                flex.addItem(phoneNumberLabel)
            }
            flex.addItem().direction(.row).justifyContent(.spaceBetween).alignItems(.center).paddingLeft(20).marginTop(12).define { flex in
                flex.addItem().direction(.row).gap(8).define { flex in
                    flex.addItem().direction(.row).gap(2).alignItems(.center).paddingVertical(4).paddingHorizontal(8).define { flex in
                        flex.addItem(lottoIcon).size(12)
                        flex.addItem(lottoLabel)
                        flex.addItem(lottoWinningCount)
                    }
                    .backgroundColor(.gray20)
                    .cornerRadius(8)
                    
                    flex.addItem().direction(.row).gap(2).alignItems(.center).paddingVertical(4).paddingHorizontal(8).define { flex in
                        flex.addItem(pensionLotteryIcon).size(12)
                        flex.addItem(pensionLotteryLabel)
                        flex.addItem(pensionLotteryWinningCount)
                    }
                    .backgroundColor(.gray20)
                    .cornerRadius(8)
                    
                    flex.addItem().direction(.row).gap(2).alignItems(.center).paddingVertical(4).paddingHorizontal(8).define { flex in
                        flex.addItem(speetoIcon).size(12)
                        flex.addItem(speetoLabel)
                        flex.addItem(speetoWinningCount)
                    }
                    .backgroundColor(.gray20)
                    .cornerRadius(8)
                }
                flex.addItem(arrowDownIcon).size(20).marginRight(20)
            }
            flex.addItem().height(1).backgroundColor(.gray20).marginTop(20)
            if sampleData.count == 0 { 
                flex.addItem().direction(.column).gap(8).alignItems(.center).paddingVertical(57).define { flex in
                    flex.addItem(noWinningHistoryCharacter).size(100)
                    flex.addItem(noWinningHistoryLabel)
                }
                .backgroundColor(.gray10)
            } else {
                flex.addItem(winningTags).width(100%).height(202)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

#Preview {
    let view = StoreInfoBottomSheetView()
    return view
}
