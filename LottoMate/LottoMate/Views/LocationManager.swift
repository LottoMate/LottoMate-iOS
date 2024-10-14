//
//  LocationManager.swift
//  LottoMate
//
//  Created by Mirae on 10/14/24.
//

import CoreLocation
import RxSwift
import RxCocoa

class LocationManager: NSObject {
    static let shared = LocationManager()
    
    private let locationManager = CLLocationManager()
    private let authorizationStatus = BehaviorRelay<CLAuthorizationStatus>(value: .notDetermined)
    private let disposeBag = DisposeBag()
    
    private override init() {
        super.init()
        setupLocationManager()
    }
    
    private func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if #available(iOS 14.0, *) {
            authorizationStatus.accept(locationManager.authorizationStatus)
        } else {
            authorizationStatus.accept(CLLocationManager.authorizationStatus())
        }
    }
    
    func requestLocationAuthorization() -> Observable<CLAuthorizationStatus> {
        return Observable.create { observer in
            self.authorizationStatus
                .take(1)
                .subscribe(onNext: { status in
                    if status == .notDetermined {
                        self.locationManager.requestWhenInUseAuthorization()
                    } else {
                        observer.onNext(status)
                        observer.onCompleted()
                    }
                })
                .disposed(by: self.disposeBag)
            
            return Disposables.create()
        }
        .concat(authorizationStatus.asObservable())
        .distinctUntilChanged()
    }
    
    func observeAuthorizationStatus() -> Observable<CLAuthorizationStatus> {
        return authorizationStatus.asObservable().distinctUntilChanged()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        if #available(iOS 14.0, *) {
            authorizationStatus.accept(manager.authorizationStatus)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authorizationStatus.accept(status)
    }
}
