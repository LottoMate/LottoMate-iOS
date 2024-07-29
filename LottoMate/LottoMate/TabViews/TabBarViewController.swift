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
        
        // MARK: Home Tab
        let homeViewController = HomeViewController()
        let homeTabIcon = UITabBarItem(title: "홈", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        homeViewController.tabBarItem = homeTabIcon
        
        // MARK: Map Tab
        let mapViewController = MapViewController()
        let mapTabIcon = UITabBarItem(title: "지도", image: UIImage(systemName: "map"), selectedImage: UIImage(systemName: "map.fill"))
        mapViewController.tabBarItem = mapTabIcon
        
        // MARK: Test Button Tab
        let testButtonViewController = TestButtonViewController()
        let testButtonTabIcon = UITabBarItem(title: "버튼", image: UIImage(systemName: "command.circle"), selectedImage: UIImage(systemName: "command.circle.fill"))
        testButtonViewController.tabBarItem = testButtonTabIcon
        
        
        let tabViewControllers = [homeViewController, mapViewController, testButtonViewController]
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
