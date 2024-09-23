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


class MapViewController: UIViewController {
    fileprivate let rootFlexContainer = UIView()
    
    var tabBarHeight: CGFloat = 13.0
    var mapHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let tabBar = self.tabBarController?.tabBar {
            tabBarHeight = tabBar.frame.size.height
        }
        
        let screenHeight = UIScreen.main.bounds.height
        mapHeight = screenHeight - tabBarHeight
        
        self.view.backgroundColor = .white
        
        let mapView = NMFMapView()
        
        rootFlexContainer.flex.define { flex in
            flex.addItem(mapView).minWidth(0).maxWidth(.infinity).height(mapHeight)
        }
        view.addSubview(rootFlexContainer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
}

#Preview {
    MapViewController()
}
