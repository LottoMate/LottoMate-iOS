//
//  DrawPickerViewController.swift
//  LottoMate
//
//  Created by Mirae on 8/3/24.
//

import UIKit

class DrawPickerViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    private let pickerView = UIPickerView()
    private let data = SampleDrawInfo.sampleData
    
    var selectedDrawInfo: ((SampleDrawInfo) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
    }
    
    private func setupPickerView() {
        pickerView.delegate = self
        pickerView.dataSource = self
        pickerView.translatesAutoresizingMaskIntoConstraints = false
        pickerView.backgroundColor = .white
        
        view.addSubview(pickerView)
        
        NSLayoutConstraint.activate([
            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            pickerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 320)
        ])
    }
    
    // UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return data.count
    }
    
    // UIPickerViewDelegate
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let drawInfo = data[row]
        return "\(drawInfo.drawNumber)회 \(drawInfo.drawDate)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedInfo = data[row]
        selectedDrawInfo?(selectedInfo)
    }
}

extension UIViewController {
    func presentDrawPickerViewController() {
        let pickerVC = DrawPickerViewController()
        pickerVC.modalPresentationStyle = .pageSheet
        pickerVC.modalTransitionStyle = .coverVertical
        
        if let sheet = pickerVC.sheetPresentationController {
            sheet.detents = [
                .custom { context in
                    return 200 // Custom height in points
                }
            ]
            sheet.prefersGrabberVisible = true
        }
        
        pickerVC.selectedDrawInfo = { selectedInfo in
            print("Selected draw info: \(selectedInfo)")
        }
        
        present(pickerVC, animated: true, completion: nil)
    }
}
