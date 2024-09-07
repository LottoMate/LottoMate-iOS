//
//  DrawPickerViewController.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//  회차 픽커 뷰

import UIKit
import PinLayout
import FlexLayout
import RxSwift
import RxGesture

class DrawPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    private let viewModel = LottoMateViewModel.shared
    fileprivate let rootFlexContainer = UIView()
    private let disposeBag = DisposeBag()
    
    private let pickerView = UIPickerView()
    private let pickerTitleLabel = UILabel()
    private let cancelButton = StyledButton(title: "취소", buttonStyle: .assistive(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    private let confirmButton = StyledButton(title: "확인", buttonStyle: .solid(.large, .active), fontSize: 16, cornerRadius: 8, verticalPadding: 12, horizontalPadding: 0)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 원하는 row (예: 1133회차의 row)를 선택 상태로 설정
        if let currentRound = viewModel.currentLottoRound.value, let data = try? viewModel.lottoDrawRoundData.value() {
            if let selectedRow = rowForDraw(round: currentRound, from: data) {
                pickerView.selectRow(selectedRow, inComponent: 0, animated: true)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        cancelButtonAction()
        
        rootFlexContainer.backgroundColor = .white
        rootFlexContainer.layer.cornerRadius = 32
        rootFlexContainer.clipsToBounds = true
        rootFlexContainer.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        
        pickerTitleLabel.text = "회차 선택"
        styleLabel(for: pickerTitleLabel, fontStyle: .headline1, textColor: .black)
        
        // 데이터가 업데이트될 때마다 pickerView를 리로드
        viewModel.lottoDrawRoundData
            .subscribe(onNext: { [weak self] _ in
                self?.pickerView.reloadAllComponents()
            })
            .disposed(by: disposeBag)
        
        view.addSubview(rootFlexContainer)
        
        rootFlexContainer.flex.direction(.column).paddingTop(32).paddingBottom(28).define { flex in
            flex.addItem(pickerTitleLabel).alignSelf(.start).paddingHorizontal(20).marginBottom(24)
            flex.addItem(pickerView).height(120)
            flex.addItem().direction(.row).justifyContent(.spaceBetween).gap(15).paddingHorizontal(20).marginTop(24).define { flex in
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
    
    func cancelButtonAction() {
        cancelButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                // 현재 ViewController를 dismiss
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
    
    func confirmButtonAction() {
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        do {
            if let data = try viewModel.lottoDrawRoundData.value() {
                return data.count
            } else {
                return 0
            }
        } catch {
            print("Error fetching data: \(error)")
            return 0
        }
    }
    
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let data = try? viewModel.lottoDrawRoundData.value()
        guard let data else { return }
        
        confirmButton.rx.tapGesture()
            .when(.recognized)
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                // 현재 ViewController를 dismiss
                let selectedRound = data[row].0
                self.viewModel.fetchLottoResult(round: selectedRound)
                self.viewModel.currentLottoRound.accept(selectedRound)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        // 마지막 아이템 도달 시 회차를 추가로 가져옴
        if row == data.count - 1 {
            viewModel.loadMoreDrawRounds()
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        /// 회차 & 날짜 컨테이너
        let containerView = UIView()
        
        let drawRoundLabel = UILabel()
        let drawDateLabel = UILabel()
        
        let data = try? viewModel.lottoDrawRoundData.value()
        if let drawInfo = data?[row] {
            let roundText = "\(drawInfo.0)회"
            drawRoundLabel.text = roundText
            drawRoundLabel.font = Typography.font(.headline1)()
            drawRoundLabel.textColor = .black
            drawRoundLabel.textAlignment = NSTextAlignment.right
            
            let dateText = drawInfo.1.reformatDate
            drawDateLabel.text = dateText
            drawDateLabel.font = Typography.font(.body1)()
            drawDateLabel.textColor = .black
            drawDateLabel.textAlignment = NSTextAlignment.left
            
            // 여러 기기에서 확인 필요
            drawRoundLabel.frame = CGRect(x: -20, y: 0, width: pickerView.bounds.width / 2, height: pickerView.rowSize(forComponent: component).height)
            drawDateLabel.frame = CGRect(x: pickerView.bounds.width / 2, y: 0, width: pickerView.bounds.width / 2, height: pickerView.rowSize(forComponent: component).height)
            
            // 라벨을 컨테이너에 추가
            containerView.addSubview(drawRoundLabel)
            containerView.addSubview(drawDateLabel)
        }
        
        containerView.backgroundColor = .red5
        containerView.frame = CGRect(x: 0, y: 0, width: pickerView.bounds.width, height: 40)
        
        pickerView.subviews.forEach {
            $0.backgroundColor = .clear
        }
        
        return containerView
    }
    
    func rowForDraw(round: Int, from data: [(Int, String)]) -> Int? {
        // data 배열에서 주어진 회차(round) 값에 해당하는 row를 찾음
        for (index, drawInfo) in data.enumerated() {
            if drawInfo.0 == round {
                return index
            }
        }
        // 만약 해당하는 회차가 없다면 nil을 반환
        return nil
    }
}
