//
//  LotteryViewController.swift
//  LottoMate
//
//  Created by Mirae on 8/22/24.
//  테스트 뷰

import UIKit
import RxSwift
import RxCocoa

class LotteryViewController: UIView {
    weak var delegate: WinningInfoDetailViewDelegate?

    private let scrollView = UIScrollView()
    private let contentView = UIView()
//    private let buttonsView = LotteryTypeButtonsView()
    
    private let disposeBag = DisposeBag()

//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        setupViews()
//        setupBindings()
//    }
    
    init() {
        super.init(frame: .zero)
        
        setupViews()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
//        addSubview(buttonsView)
        
        // Layout constraints
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
//        buttonsView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
//            buttonsView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
//            buttonsView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//            buttonsView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//            buttonsView.heightAnchor.constraint(equalToConstant: 50),

//            scrollView.topAnchor.constraint(equalTo: buttonsView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor) // Important for horizontal scrolling
        ])
    }

    private func setupBindings() {
//        buttonsView.selectedLotteryType
//            .subscribe(onNext: { [weak self] type in
//                self?.handleLotteryTypeSelection(type)
//            })
//            .disposed(by: disposeBag)
    }

    private func handleLotteryTypeSelection(_ lotteryType: LotteryType) {
        // Remove all subviews from contentView
        contentView.subviews.forEach { $0.removeFromSuperview() }
        
        // Create the appropriate view based on selected lottery type
        let selectedView: UIView
        switch lotteryType {
        case .lotto:
            selectedView = createLottoView()
        case .pensionLottery:
            selectedView = createPensionView()
        case .speeto:
            selectedView = createSpeetoView()
        }
        
        // Add the selected view to contentView
        contentView.addSubview(selectedView)
        
        // Layout constraints for selectedView
        selectedView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            selectedView.topAnchor.constraint(equalTo: contentView.topAnchor),
            selectedView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            selectedView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            selectedView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            selectedView.heightAnchor.constraint(equalTo: scrollView.heightAnchor) // Ensure the height is equal to the scroll view
        ])
    }
    
    private func createLottoView() -> UIView {
        let view = UIView()
        view.backgroundColor = .yellow // Example background color
        return view
    }
    
    private func createPensionView() -> UIView {
        let view = UIView()
        view.backgroundColor = .purple // Example background color
        return view
    }
    
    private func createSpeetoView() -> UIView {
        let view = UIView()
        view.backgroundColor = .orange // Example background color
        return view
    }
}

#Preview {
    let preview = LotteryViewController()
    return preview
}
