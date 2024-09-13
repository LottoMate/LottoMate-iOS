//
//  TabBarViewController.swift
//  LottoMate
//
//  Created by Mirae on 7/26/24.
//  The current initial view controller.

import UIKit

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        tabBar.barTintColor = UIColor.white
        
        let normalAttributes = [NSAttributedString.Key.font: Typography.caption.font(), NSAttributedString.Key.foregroundColor: UIColor.gray]
        let selectedAttributes = [NSAttributedString.Key.font: Typography.caption.font(), NSAttributedString.Key.foregroundColor: UIColor.red50Default]

        UITabBarItem.appearance().setTitleTextAttributes(normalAttributes, for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes(selectedAttributes, for: .selected)
        
        
        // MARK: 홈
        let homeViewController = HomeViewController()
        let homeTabIcon = UITabBarItem(title: "홈", image: UIImage(named: "icon_clover"), selectedImage: UIImage(named: "icon_clover_selected"))
        homeViewController.tabBarItem = homeTabIcon
        homeViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        
        // MARK: 지도
        let mapViewController = MapViewController()
        let mapTabIcon = UITabBarItem(title: "지도", image: UIImage(named: "icon_map"), selectedImage: UIImage(named: "icon_map_selected"))
        mapViewController.tabBarItem = mapTabIcon
        mapViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        
        // MARK: 보관소
        let storageViewController = WinningNumbersDetailViewController()
        let storageTabIcon = UITabBarItem(title: "보관소", image: UIImage(named: "icon_pocket"), selectedImage: UIImage(named: "icon_pocket_selected"))
        storageViewController.tabBarItem = storageTabIcon
        storageViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        
        // MARK: 라운지
        let loungeViewController = WinningNumbersDetailViewController()
        let loungeTabIcon = UITabBarItem(title: "라운지", image: UIImage(named: "icon_person2"), selectedImage: UIImage(named: "icon_person2_selected"))
        loungeViewController.tabBarItem = loungeTabIcon
        loungeViewController.tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -3)
        
        
        let tabViewControllers = [homeViewController, mapViewController, storageViewController, loungeViewController]
        self.viewControllers = tabViewControllers
    }
}

extension TabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        print("Should select viewController: \(viewController.title ?? "") ?")
        return true;
    }
}

#Preview {
    let preview = TabBarViewController()
    return preview
}
