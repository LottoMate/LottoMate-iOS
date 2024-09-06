//
//  CustomSquareButton.swift
//  LottoMate
//
//  Created by Mirae on 9/4/24.
//

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxRelay
import RxGesture

enum SpeetoType: CaseIterable {
    case the2000
    case the1000
    case the500
}

class CustomSquareButton: UIView {
    fileprivate let rootFlexContainer = UIView()
    let viewModel = LottoMateViewModel.shared
    
    let titleLabel2000 = UILabel()
    let titleLabel1000 = UILabel()
    let titleLabel500 = UILabel()
    
    let bottomBorder2000 = UIView()
    let bottomBorder1000 = UIView()
    let bottomBorder500 = UIView()
    
    let disposeBag = DisposeBag()
    
    let speetoType = BehaviorRelay<SpeetoType>(value: .the2000)
    
    init() {
        super.init(frame: .zero)
        
        titleLabel2000.text = "2000"
        titleLabel1000.text = "1000"
        titleLabel500.text = "500"
        
        styleLabel(for: titleLabel2000, fontStyle: .headline2, textColor: .black)
        styleLabel(for: titleLabel1000, fontStyle: .headline2, textColor: .gray60)
        styleLabel(for: titleLabel500, fontStyle: .headline2, textColor: .gray60)
        
        buttonTapGesture()
        buttonStyle()
        
        addSubview(rootFlexContainer)
        rootFlexContainer.flex.direction(.column).paddingTop(10).define { flex in
            flex.addItem().direction(.row).gap(16).paddingHorizontal(20).define { flex in
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(titleLabel2000).width(40).marginBottom(8)
                    flex.addItem(bottomBorder2000).height(2)
                }
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(titleLabel1000).width(40).marginBottom(8)
                    flex.addItem(bottomBorder1000).height(2)
                }
                flex.addItem().direction(.column).define { flex in
                    flex.addItem(titleLabel500).width(40).marginBottom(8)
                    flex.addItem(bottomBorder500).height(2)
                }
            }
            flex.addItem().height(1).backgroundColor(.gray20)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        rootFlexContainer.pin.top(pin.safeArea).horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    func buttonTapGesture() {
        titleLabel2000.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                viewModel.speetoTypeTapEvent.accept(.the2000)
            })
            .disposed(by: disposeBag)
        
        titleLabel1000.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                viewModel.speetoTypeTapEvent.accept(.the1000)
            })
            .disposed(by: disposeBag)
        
        titleLabel500.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                viewModel.speetoTypeTapEvent.accept(.the500)
            })
            .disposed(by: disposeBag)
        
    }
    func buttonStyle() {
        viewModel.speetoTypeTapEvent
            .subscribe(onNext: { type in
                guard let speetoType = type else { return }
                
                self.titleLabel2000.textColor = speetoType == .the2000 ? .black : .gray60
                self.titleLabel1000.textColor = speetoType == .the1000 ? .black : .gray60
                self.titleLabel500.textColor = speetoType == .the500 ? .black : .gray60
                
                self.bottomBorder2000.backgroundColor = speetoType == .the2000 ? .red50Default : .white
                self.bottomBorder1000.backgroundColor = speetoType == .the1000 ? .red50Default : .white
                self.bottomBorder500.backgroundColor = speetoType == .the500 ? .red50Default : .white
                
            })
            .disposed(by: disposeBag)
    }
}

#Preview {
    let view = CustomSquareButton()
    return view
}
