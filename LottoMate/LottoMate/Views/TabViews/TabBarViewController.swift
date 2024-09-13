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
        
        // MARK: 홈
        let homeViewController = HomeViewController()
        let homeTabIcon = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeViewController.tabBarItem = homeTabIcon
        
        // MARK: 지도
        let mapViewController = WinningNumbersDetailViewController()
        let mapTabIcon = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapViewController.tabBarItem = mapTabIcon
        
        // MARK: 보관소
        let storageViewController = WinningNumbersDetailViewController()
        let storaTabIcon = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapViewController.tabBarItem = mapTabIcon
        
        // MARK: 라운지
        let loungeViewController = WinningNumbersDetailViewController()
        let loungeTabIcon = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapViewController.tabBarItem = mapTabIcon
        
        
        let tabViewControllers = [homeViewController, mapViewController]
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
