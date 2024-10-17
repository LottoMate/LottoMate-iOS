//
//  MapView.swift
//  LottoMate
//
//  Created by Mirae on 7/26/24.
//

import UIKit
import CoreLocation
import NMapsMap
import FlexLayout
import PinLayout
import ReactorKit
import RxSwift
import RxGesture
import BottomSheet

class MapViewController: UIViewController, View, CLLocationManagerDelegate {
    
    let reactor = MapViewReactor()
    var disposeBag = DisposeBag()
    
    fileprivate let rootFlexContainer = UIView()
    
    let mapView = NMFMapView()
    var currentMarker: NMFMarker?
    var mapHeight: CGFloat = 0
    var tabBarHeight: CGFloat = 0.0
    
    let filterButton = ShadowRoundButton(title: "복권 전체", icon: UIImage(named: "icon_filter"))
    let winningStoreButton = ShadowRoundButton(title: "당첨 판매점")
    let savedStoreButton = ShadowRoundButton(title: "찜")
    let refreshButton = ShadowRoundButton(icon: UIImage(named: "icon_refresh"))
    let currentLocationButton = ShadowRoundButton(icon: UIImage(named: "icon_ location"))
    let listButton = ShadowRoundButton(icon: UIImage(named: "icon_list"))
    
    lazy var bottomSheet: CustomBottomSheetViewController = {
        let contentVC = StoreInfoBottomSheetViewController()
        let bottomSheet = CustomBottomSheetViewController(contentViewController: contentVC, minHeight: 48, maxHeight: 423)
        return bottomSheet
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        bind(reactor: reactor)
        
        addChild(bottomSheet)
        view.addSubview(bottomSheet.view)
        bottomSheet.didMove(toParent: self)
        
        let screenHeight = UIScreen.main.bounds.height
        if let tabBarHeight = self.tabBarController?.tabBar.frame.size.height {
            self.tabBarHeight = tabBarHeight
        }
        mapHeight = screenHeight - self.tabBarHeight
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(mapView).minWidth(0).maxWidth(.infinity).height(mapHeight)
            flex.addItem(filterButton)
                .width(98)
                .height(38)
                .marginTop(8)
                .marginLeft(20)
                .position(.absolute)  // 버튼을 지도 위에 오버레이
            
            flex.addItem(winningStoreButton)
                .width(98)
                .height(38)
                .position(.absolute)
            
            flex.addItem(savedStoreButton)
                .width(45)
                .height(38)
                .marginTop(8)
                .position(.absolute)
            
            flex.addItem(refreshButton)
                .width(40)
                .height(40)
                .position(.absolute)
            
            flex.addItem(currentLocationButton)
                .width(40)
                .height(40)
                .position(.absolute)
            
            flex.addItem(listButton)
                .width(40)
                .height(40)
                .position(.absolute)
            
            flex.addItem(bottomSheet.view)
                .width(100%)
                .position(.absolute)
        }
        view.addSubview(rootFlexContainer)
        bottomSheet.addToParent(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        filterButton.pin.top(view.safeAreaInsets)
        savedStoreButton.pin.top(view.safeAreaInsets).right().marginRight(20)
        winningStoreButton.pin.left(of: savedStoreButton, aligned: .center).marginRight(8)
        
        refreshButton.pin.above(of: bottomSheet.view, aligned: .left).marginLeft(20).marginBottom(28)
        currentLocationButton.pin.above(of: bottomSheet.view, aligned: .right).marginRight(20).marginBottom(28)
        listButton.pin.above(of: currentLocationButton, aligned: .center).marginBottom(20)
    }
    
    func bind(reactor: MapViewReactor) {
        // 복권 종류 필터 버튼 Action
        filterButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MapViewReactor.Action.filterButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        // 복권 종류 필터 버튼 State
        reactor.state
            .map { $0.isfilterBottomSheetVisible }
            .subscribe(onNext: { [weak self] isVisible in
                if isVisible {
                    self?.showLotteryTypeFilter()
                }
            })
            .disposed(by: self.disposeBag)
        
        // 현재 위치 버튼 Action
        currentLocationButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MapViewReactor.Action.getCurrentLocation }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        // 현재 위치 버튼 State
        reactor.state
            .map { $0.currentLocation }
            .distinctUntilChanged()
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] location in
                print("Location received: \(location)")
                self?.moveToLocation(location)
                self?.updateMarker(at: location)
            })
            .disposed(by: disposeBag)
    }
    
    func moveToLocation(_ location: CLLocation) {
        let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude))
        cameraUpdate.animation = .easeIn
        mapView.moveCamera(cameraUpdate)
    }
    
    func updateMarker(at location: CLLocation) {
        // 현재 위치에 이미 마커가 있다면 제거
        currentMarker?.mapView = nil
        
        let marker = NMFMarker()
        marker.position = NMGLatLng(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
        marker.iconImage = NMFOverlayImage(name: "currentLocationMarker")
        marker.mapView = mapView
        
        currentMarker = marker
    }
    
    func showLotteryTypeFilter() {
        let viewController = LotteryTypeFilterBottomSheetViewController()
        
        viewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.3)
        
        presentBottomSheet(viewController: viewController, configuration: BottomSheetConfiguration(
            cornerRadius: 0,
            pullBarConfiguration: .hidden,
            shadowConfiguration: .default
        ), canBeDismissed: {
            true
        }, dismissCompletion: {
            
        })
    }
}

#Preview {
    MapViewController()
}
