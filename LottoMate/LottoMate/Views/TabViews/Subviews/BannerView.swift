//
//  BannerView.swift
//  LottoMate
//
//  Created by Mirae on 8/27/24.
//

import UIKit
import PinLayout
import FlexLayout

class BannerView: UIView {
    fileprivate let rootFlexContainer = UIView()
    
    /// 배너에 들어가는 캐릭터 이미지
    var bannerImage = UIImageView()
    /// 배너 타이틀 레이블
    let titleTextLabel = UILabel()
    /// 배너 바디 레이블
    let bodyTextLabel = UILabel()
    
    init(bannerBackgroundColor: UIColor, bannerImageName: String?, titleText: String, bodyText: String) {
        super.init(frame: .zero)
        
        backgroundColor = bannerBackgroundColor
        layer.cornerRadius = 16
        
        titleTextLabel.text = titleText
        titleTextLabel.numberOfLines = 2
        titleTextLabel.frame = CGRect(x: 0, y: 0, width: 94, height: 48)
        styleLabel(for: titleTextLabel, fontStyle: .headline2, textColor: .black, alignment: .left)
        bodyTextLabel.text = bodyText
        styleLabel(for: bodyTextLabel, fontStyle: .caption1, textColor: .gray90)
        
        if let imageName = bannerImageName {
            bannerImage.image = UIImage(named: imageName)
            bannerImage.contentMode = .scaleAspectFit
            bannerImage.frame = CGRect(x: 0, y: 0, width: 124, height: 78)
        }
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.row).justifyContent(.spaceBetween).paddingTop(15).paddingLeft(20).paddingRight(18).paddingBottom(7).define { flex in
            flex.addItem().direction(.column).define { flex in
                flex.addItem(titleTextLabel).marginBottom(4)
                flex.addItem(bodyTextLabel)
            }
            flex.addItem(bannerImage)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

#Preview {
    let view = BannerView(bannerBackgroundColor: .yellow5, bannerImageName: "img_banner_coins", titleText: "행운의 1등 로또 어디서 샀을까?", bodyText: "당첨 판매점 보러가기")
    return view
}
