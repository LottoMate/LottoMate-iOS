//
//  LottoMateTests.swift
//  LottoMateTests
//
//  Created by Mirae on 7/23/24.
//

import XCTest
import RxSwift
import RxTest
import RxBlocking
import CoreLocation
import NMapsMap
@testable import LottoMate

final class LottoMateTests: XCTestCase {
    var viewController: MapViewController?
    var reactor: MapViewReactor?
    var disposeBag: DisposeBag?
    var scheduler: TestScheduler?

    override func setUpWithError() throws {
        try super.setUpWithError()
        viewController = MapViewController()
        reactor = MapViewReactor()
        viewController?.reactor = reactor
        disposeBag = DisposeBag()
        scheduler = TestScheduler(initialClock: 0)
        
        // Load the view hierarchy
        viewController?.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        viewController = nil
        reactor = nil
        disposeBag = nil
        scheduler = nil
        try super.tearDownWithError()
    }

    func testUpdateMarker() throws {
        guard let viewController = viewController else {
            XCTFail("ViewController is nil")
            return
        }
        
        // 서울시청
        let location1 = CLLocation(latitude: 37.550263, longitude: 126.9970831)
        // N서울타워
        let location2 = CLLocation(latitude: 37.5511694, longitude: 126.9882266)
        
        XCTAssertNil(viewController.currentMarker)
        
        viewController.updateMarker(at: location1)
        
        XCTAssertNotNil(viewController.currentMarker)
        XCTAssertEqual(viewController.currentMarker?.position.lat, location1.coordinate.latitude)
        XCTAssertEqual(viewController.currentMarker?.position.lng, location1.coordinate.longitude)
        
        let firstMarker = viewController.currentMarker
        
        viewController.updateMarker(at: location2)
        
        XCTAssertNotNil(viewController.currentMarker)
        XCTAssertNotEqual(viewController.currentMarker, firstMarker)
        XCTAssertEqual(viewController.currentMarker?.position.lat, location2.coordinate.latitude)
        XCTAssertEqual(viewController.currentMarker?.position.lng, location2.coordinate.longitude)
    }
}
