//
//  DrawPickerViewController.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//  회차 픽커 뷰

import UIKit
import PinLayout
import FlexLayout

class DrawPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    fileprivate let rootFlexContainer = UIView()
    
    private let pickerView = UIPickerView()
    private let data = SampleDrawInfo.sampleData
    private let pickerTitleLabel = UILabel()
    public let cancelButton = StyledButton(title: "취소", buttonStyle: .assistive(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    public let confirmButton = StyledButton(title: "확인", buttonStyle: .solid(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    
    var selectedDrawInfo: ((SampleDrawInfo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.cornerRadius = 32
        rootFlexContainer.clipsToBounds = true
        rootFlexContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        pickerTitleLabel.text = "회차 선택"
        styleLabel(for: pickerTitleLabel, fontStyle: .headline1, textColor: .black)
        
        view.addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingTop(32).paddingBottom(28).define { flex in
            flex.addItem(pickerTitleLabel).alignSelf(.start).paddingHorizontal(20).marginBottom(14)
            flex.addItem(pickerView).height(120)
            flex.addItem().direction(.row).justifyContent(.spaceBetween).gap(15).paddingHorizontal(20).marginTop(14).define { flex in
                flex.addItem(cancelButton).grow(1)
                flex.addItem(confirmButton).grow(1)
            }
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.bottom().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let drawInfo = data[row]
        return "\(drawInfo.drawNumber)회 \(drawInfo.drawDate)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedInfo = data[row]
        selectedDrawInfo?(selectedInfo)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        let drawInfo = data[row]
        var pickerLabelText = "\(drawInfo.drawNumber)회 \(drawInfo.drawDate)"
        pickerLabel.text = pickerLabelText
        pickerLabel.font = Typography.font(.headline1)()
        pickerLabel.textAlignment = NSTextAlignment.center
        
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }
        
        return pickerLabel
    }
}
