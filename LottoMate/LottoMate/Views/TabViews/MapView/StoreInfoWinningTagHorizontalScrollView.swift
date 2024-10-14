//
//  StoreInfoWinningTagHorizontalScrollView.swift
//  LottoMate
//
//  Created by Mirae on 10/8/24.
//

import UIKit
import PinLayout
import FlexLayout

class StoreInfoWinningTagHorizontalScrollView: UIView {
    fileprivate let rootFlexContainer = UIView()
    fileprivate let scrollView = UIScrollView()
    
    let sampleData = StoreInfoSampleData.drwtList
    
    let winningTagsContainer = UIView()
    
    
    init() {
        super.init(frame: .zero)
        
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = false
        scrollView.addSubview(rootFlexContainer)
        addSubview(scrollView)
        
        rootFlexContainer.flex.direction(.row).gap(16).paddingLeft(20).paddingTop(20).paddingRight(20).paddingBottom(14).define { flex in
            let itemsPerColumn = 5
            let itemCount = sampleData.count
            let columns = Int(ceil(Double(itemCount) / Double(itemsPerColumn))) // 총 몇 개의 컬럼이 필요한지 계산
            
            for columnIndex in 0..<columns {
                flex.addItem().direction(.column).gap(8).define { columnFlex in
                    let startIndex = columnIndex * itemsPerColumn
                    let endIndex = min(startIndex + itemsPerColumn, itemCount)
                    
                    for i in startIndex..<endIndex {
                        
                        let lotteryTypeLabel = UILabel()
                        lotteryTypeLabel.text = "\(sampleData[i].typeText)"
                        styleLabel(for: lotteryTypeLabel, fontStyle: .label1, textColor: .black)
                        
                        let prizeMoney = UILabel()
                        prizeMoney.text = "\(sampleData[i].prizeMoney) 당첨"
                        styleLabel(for: prizeMoney, fontStyle: .label2, textColor: .black)
                        
                        let roundNumber = UILabel()
                        roundNumber.text = "\(sampleData[i].lottoRndNum)회"
                        styleLabel(for: roundNumber, fontStyle: .caption1, textColor: .gray100)
                        
                        columnFlex.addItem().direction(.row).gap(4).paddingVertical(4).paddingHorizontal(12).define { flex in
                            flex.addItem(lotteryTypeLabel)
                            flex.addItem(prizeMoney)
                            flex.addItem(roundNumber)
                        }
                        .backgroundColor(sampleData[i].backgroundColor)
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.pin.all()
        rootFlexContainer.pin.top(pin.safeArea.top).left().bottom()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        rootFlexContainer.flex.layout(mode: .adjustWidth)
        scrollView.contentSize = rootFlexContainer.frame.size
    }
}

#Preview {
    StoreInfoWinningTagHorizontalScrollView()
}
