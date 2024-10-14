//
//  SceneDelegate.swift
//  LottoMate
//
//  Created by Mirae on 7/23/24.
//

import UIKit
import RxSwift

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private let disposeBag = DisposeBag()

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window?.windowScene = windowScene
        window?.makeKeyAndVisible()
        
        let tabBarController = TabBarViewController()
//        let tabBarController = LoginViewController()
        
        let navigationController = UINavigationController(rootViewController: tabBarController)
        navigationController.setNavigationBarHidden(true, animated: false)
        
        window?.rootViewController = navigationController
        
        // 맵 로딩 뷰
        // LoadingViewManager.shared.showLoading()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            LocationManager.shared.requestLocationAuthorization()
                .subscribe(onNext: { status in
                    switch status {
                    case .authorizedWhenInUse, .authorizedAlways:
                        print("Location access granted")
                        // 위치 기반 기능 초기화
                    case .denied, .restricted:
                        print("Location access denied")
                        // 사용자에게 위치 권한이 필요하다는 메시지 표시
                    case .notDetermined:
                        print("Location access not determined")
                        // 사용자가 아직 선택하지 않음
                    @unknown default:
                        break
                    }
                })
                .disposed(by: self.disposeBag)
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

