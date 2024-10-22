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
    private let currentLocation = BehaviorRelay<CLLocation?>(value: nil)
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
    
    func getCurrentLocation() -> Observable<CLLocation> {
        return Observable.create { observer in
            let authorizationDisposable = self.authorizationStatus
                .filter { $0 == .authorizedWhenInUse || $0 == .authorizedAlways }
                .take(1)
                .subscribe(onNext: { _ in
                    self.locationManager.startUpdatingLocation()
                })

            let locationDisposable = self.currentLocation
                .compactMap { $0 }
                .take(1)
                .subscribe(onNext: { location in
                    observer.onNext(location)
                    observer.onCompleted()
                })

            return Disposables.create([authorizationDisposable, locationDisposable])
        }
    }
    
    func loadStoreList() -> Observable<[StoreInfo]> {
        return Observable.create { observer in
            // 샘플 데이터 로드 시뮬레이션
            DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) { // 1초 지연을 주어 네트워크 요청을 시뮬레이션
                guard let storeList = JSONLoader.loadStoreList()?.storeInfo else {
                    observer.onError(NSError(domain: "com.example.LottoMate", code: 0, userInfo: [NSLocalizedDescriptionKey: "No sample data available"]))
                    return
                }
                
                observer.onNext(storeList)
                observer.onCompleted()
            }
            
            return Disposables.create()
        }
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
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        currentLocation.accept(location)
        locationManager.stopUpdatingLocation()
    }
}
