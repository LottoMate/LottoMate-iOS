//
//  TestHomeView .swift
//  LottoMate
//
//  Created by Mirae on 7/25/24.
//

import UIKit
import FlexLayout
import PinLayout

class TestButtonView: UIView {
    fileprivate let rootFlexContainer = UIView()
    public let defaultSolidButton = StyledButton(title: "Test Button", buttonStyle: .solid(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 0, horizontalPadding: 0)
    let testLabel = UILabel()
    let testLabel2 = UILabel()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        defaultSolidButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        testLabel.text = "당첨 번호 상세"
        styleLabel(for: testLabel, fontStyle: .caption, textColor: .black)
        testLabel2.text = "당첨 번호 정보"
        styleLabel(for: testLabel2, fontStyle: .headline1, textColor: .black)

             
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).alignItems(.center).define { flex in
            flex.addItem(defaultSolidButton).width(127).height(48)
            flex.addItem(testLabel).border(1, .blue)
            flex.addItem(testLabel2).border(1, .red)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        rootFlexContainer.pin.top().horizontally().margin(pin.safeArea)
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    @objc func buttonTapped(_ sender: Any) {
        print("Button tapped")
    }
    
    func setLineHeight(for label: UILabel, lineHeight: CGFloat) {
        // 텍스트가 없으면 빈 문자열로 초기화
        let text = label.text ?? ""
        
        // NSMutableParagraphStyle을 생성하고 line height를 설정
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.minimumLineHeight = lineHeight
        paragraphStyle.maximumLineHeight = lineHeight
        paragraphStyle.alignment = .left // 원하는 정렬 방식으로 설정
        
        // NSAttributedString을 생성하고 텍스트와 paragraphStyle을 적용
        let attributes: [NSAttributedString.Key: Any] = [
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        
        // UILabel에 attributedText를 설정
        label.attributedText = attributedString
    }
}

#Preview {
    let preview = TestButtonView()
    return preview
}
