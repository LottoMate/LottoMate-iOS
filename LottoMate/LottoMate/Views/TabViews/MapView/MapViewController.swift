//
//  MapView.swift
//  LottoMate
//
//  Created by Mirae on 7/26/24.
//

import UIKit
import NMapsMap
import FlexLayout
import PinLayout
import ReactorKit
import RxSwift
import RxGesture
import BottomSheet

class MapViewController: UIViewController, View {
    
    var disposeBag = DisposeBag()
    let reactor = MapViewReactor()
    
    fileprivate let rootFlexContainer = UIView()
    
    var mapHeight: CGFloat = 0
    let filterButton = ShadowRoundButton(title: "복권 전체", icon: UIImage(named: "icon_filter"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind(reactor: reactor)
        
        let screenHeight = UIScreen.main.bounds.height
        mapHeight = screenHeight
        
        self.view.backgroundColor = .white
        
        let mapView = NMFMapView()
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(mapView).minWidth(0).maxWidth(.infinity).height(mapHeight)
            flex.addItem(filterButton)
                .width(98)
                .height(38)
                .marginTop(8)
                .marginLeft(20)
                .position(.absolute)  // 버튼을 지도 위에 오버레이
                .border(1, .red)
        }
        view.addSubview(rootFlexContainer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        filterButton.pin.top(view.safeAreaInsets)
    }
    
    func bind(reactor: MapViewReactor) {
        // 필터 버튼을 눌렀을 때 액션을 전송
        filterButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MapViewReactor.Action.filterButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isBottomSheetVisible }
            .subscribe(onNext: { [weak self] isVisible in
                if isVisible {
                    self?.showDrawRoundTest()
                    print("isVisible")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func showDrawRoundTest() {
        let viewController = DrawPickerViewController()
        viewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.25)
        
        presentBottomSheet(viewController: viewController, configuration: BottomSheetConfiguration(
            cornerRadius: 32,
            pullBarConfiguration: .hidden,
            shadowConfiguration: .default
        ), canBeDismissed: {
            true
        }, dismissCompletion: {
            // handle bottom sheet dismissal completion
        })
    }
}

#Preview {
    MapViewController()
}
