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
    
    var disposeBag = DisposeBag()
    let reactor = MapViewReactor()
    
    var locationManager = CLLocationManager()
    
    fileprivate let rootFlexContainer = UIView()
    
    var mapHeight: CGFloat = 0
    var tabBarHeight: CGFloat = 0.0
    let filterButton = ShadowRoundButton(title: "복권 전체", icon: UIImage(named: "icon_filter"))
    let winningStoreButton = ShadowRoundButton(title: "당첨 판매점")
    let savedStoreButton = ShadowRoundButton(title: "찜")
    let refreshButton = ShadowRoundButton(icon: UIImage(named: "icon_refresh"))
    let currentLocationButton = ShadowRoundButton(icon: UIImage(named: "icon_ location"))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        bind(reactor: reactor)
        
        let mapView = NMFMapView()
        
        let screenHeight = UIScreen.main.bounds.height
        if let tabBarHeight = self.tabBarController?.tabBar.frame.size.height {
            self.tabBarHeight = tabBarHeight
        }
        mapHeight = screenHeight - self.tabBarHeight
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            print("위치 서비스 On")
            locationManager.startUpdatingLocation()
            
            // 현재 위치를 구하지 못할 경우 기본값으로 들어갈 값 정하기 (예: 서울 시청의 좌표)
            let longitude = locationManager.location?.coordinate.longitude ?? 0
            let latitude = locationManager.location?.coordinate.latitude ?? 0
            let currentLocation = NMGLatLng(lat: latitude, lng: longitude)
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: currentLocation)
            cameraUpdate.animation = .easeIn
            mapView.moveCamera(cameraUpdate)
            
            let marker = NMFMarker()
            marker.position = currentLocation
            marker.mapView = mapView
            
        } else {
            print("위치 서비스 Off")
        }
        
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
        }
        view.addSubview(rootFlexContainer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
        
        filterButton.pin.top(view.safeAreaInsets)
        savedStoreButton.pin.top(view.safeAreaInsets).right().marginRight(20)
        winningStoreButton.pin.left(of: savedStoreButton, aligned: .center).marginRight(8)
        refreshButton.pin.bottom().left().marginLeft(20).marginBottom(78)
        currentLocationButton.pin.bottom().right().marginRight(20).marginBottom(78)
    }
    
    func bind(reactor: MapViewReactor) {
        // 필터 버튼을 눌렀을 때 액션을 전송
        filterButton.rx.tapGesture()
            .when(.recognized)
            .map { _ in MapViewReactor.Action.filterButtonTapped }
            .bind(to: reactor.action)
            .disposed(by: self.disposeBag)
        
        reactor.state
            .map { $0.isfilterBottomSheetVisible }
            .subscribe(onNext: { [weak self] isVisible in
                if isVisible {
                    self?.showDrawRoundTest()
                    print("isVisible")
                }
            })
            .disposed(by: self.disposeBag)
    }
    
    func showDrawRoundTest() {
        let viewController = LotteryTypeFilterBottomSheetViewController()
        viewController.preferredContentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.width / 1.3)
        
        presentBottomSheet(viewController: viewController, configuration: BottomSheetConfiguration(
            cornerRadius: 0,
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
