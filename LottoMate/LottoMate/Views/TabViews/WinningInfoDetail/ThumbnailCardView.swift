//
//  ThumbnailCardView.swift
//  LottoMate
//
//  Created by Mirae on 9/13/24.
//

import UIKit
import PinLayout
import FlexLayout

class ThumbnailCardView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    var imageView: UIImageView!
    var imageName: String = ""
    
    let lotteryInfoLabel = UILabel()
    let titleLabel = UILabel()
    let dateLabel = UILabel()
    
    init() {
        super.init(frame: .zero)
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.cornerRadius = 16
        
        let shadowOffset = CGSize(width: 0, height: 0)
        rootFlexContainer.addShadow(offset: shadowOffset, color: UIColor.black, radius: 4, opacity: 0.15)
        
        setupLabels()
        setupImageView()
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex.direction(.column).define { flex in
            flex.addItem(imageView).height(50%).minWidth(0).maxWidth(.infinity)
            flex.addItem().direction(.column).alignItems(.start).paddingTop(13).paddingBottom(6).paddingLeft(16).paddingRight(57).define { flex in
                flex.addItem(lotteryInfoLabel)
                flex.addItem(titleLabel)
                flex.addItem(dateLabel)
            }
        }.height(200).maxWidth(220)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea.top).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func setupLabels() {
        lotteryInfoLabel.text = "연금복권 1등"
        styleLabel(for: lotteryInfoLabel, fontStyle: .caption, textColor: .gray80)
        
        titleLabel.numberOfLines = 2
        titleLabel.text = "사회 초년생 시절부터 꾸준히 구매해서 1등 당첨"
        styleLabel(for: titleLabel, fontStyle: .label2, textColor: .black, alignment: .left)
        
        dateLabel.text = "YYYY.MM.DD"
        styleLabel(for: dateLabel, fontStyle: .caption, textColor: .gray80)
    }
    
    func setupImageView() {
        imageView = UIImageView()
        imageName = "winning_review_sample_1"
        imageView.image = UIImage(named: imageName)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 16
        imageView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
    }
}

#Preview {
    let view = ThumbnailCardView()
    return view
}
