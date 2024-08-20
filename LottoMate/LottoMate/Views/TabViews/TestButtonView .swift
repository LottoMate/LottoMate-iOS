//
//  TestHomeView .swift
//  LottoMate
//
//  Created by Mirae on 7/25/24.
//

import UIKit
import FlexLayout
import PinLayout
import SwiftSoup

class TestButtonView: UIView {
    fileprivate let rootFlexContainer = UIView()
    public let defaultSolidButton = StyledButton(title: "Test Button", buttonStyle: .solid(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 0, horizontalPadding: 0)
    let textView = UITextView()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
        defaultSolidButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        let boldTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.boldSystemFont(ofSize: 16) // 굵은 폰트
        ]
        
        let smallTextAttributes: [NSAttributedString.Key: Any] = [
            .font: UIFont.systemFont(ofSize: 12) // 작은 폰트
        ]
        
        
//        textView.font = UIFont.systemFont(ofSize: 14)
        parseHtml()
        
        addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).alignItems(.center).paddingHorizontal(10).define { flex in
            flex.addItem(defaultSolidButton).width(127).height(48).marginBottom(48)
            flex.addItem(textView).grow(1)
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
    
    func parseHtml() {
        do {
            let html = SampleHtmlDoc.sampleData
            let doc: Document = try SwiftSoup.parse(html)
            let elements: Elements = try doc.select("div")
            
            let lineSpacing: CGFloat = 2.0
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = lineSpacing
            
            let attributedString = NSMutableAttributedString()
            
            for div in elements {
                let text = try div.text()
                var attributes = [NSAttributedString.Key: Any]()
                
                if text.first == "▶" {
                    let boldTextAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.boldSystemFont(ofSize: 14),
                        .paragraphStyle: paragraphStyle
                    ]
                    let atrributedText = NSAttributedString(string: (text + "\n"), attributes: boldTextAttributes)
                    attributedString.append(atrributedText)
                    
                } else if text.prefix(2) == "->" {
                    let smallTextAttributes: [NSAttributedString.Key: Any] = [
                        .font: UIFont.systemFont(ofSize: 12),
                        .paragraphStyle: paragraphStyle
                    ]
                    let atrributedText = NSAttributedString(string: (text + "\n\n"), attributes: smallTextAttributes)
                    attributedString.append(atrributedText)
                    
                } else {
                    // Default style 주기
                }
            }
            textView.attributedText = attributedString
            
        } catch Exception.Error(_, let message) {
            print("parseHtml message: \(message)")
        } catch {
            print("An error occurs parsing html doc.")
        }
    }
}

#Preview {
    let preview = TestButtonView()
    return preview
}
