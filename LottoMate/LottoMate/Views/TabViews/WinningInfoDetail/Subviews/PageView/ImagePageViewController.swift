//
//  ImagePageViewController.swift
//  LottoMate
//
//  Created by Mirae on 9/12/24.
//

import UIKit
import FlexLayout
import PinLayout

class ImagePageViewController: UIViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    fileprivate let rootFlexContainer = UIView()
    
    var pageViewController: UIPageViewController!
    var pageControl = UIPageControl()
    
    var gradientLayer: CAGradientLayer!
    
    // 보여줄 이미지 배열
    let images = ["winning_review_sample_1", "winning_review_sample_2", "winning_review_sample_3"]
    
    // 이미지 뷰의 비율
    let imageAspectRatio: CGFloat = 1.34
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 페이지 뷰 컨트롤러 설정
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        // 첫 번째 뷰 컨트롤러로 시작
        let startingViewController = getViewControllerAtIndex(0)!
        
        pageViewController.setViewControllers([startingViewController], direction: .forward, animated: false, completion: nil)
        
        // 페이지 뷰 컨트롤러 추가
        addChild(pageViewController)
//        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        // 페이지 뷰 컨트롤러의 크기 설정
        setupPageViewControllerSize()
        
        // 페이지 컨트롤 추가
        setupGradientOverlay()
        setupPageControl()
        
        view.backgroundColor = .white
        
        view.addSubview(rootFlexContainer)
        rootFlexContainer.flex.define { flex in
            flex.addItem(pageViewController.view)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        rootFlexContainer.pin.top().horizontally()
        rootFlexContainer.flex.layout(mode: .adjustHeight)
    }
    
    // 페이지 뷰 컨트롤러의 크기를 화면 너비에 맞추고 비율에 따라 높이를 설정
    func setupPageViewControllerSize() {
        let screenWidth = UIScreen.main.bounds.width
        let pageViewHeight = screenWidth / imageAspectRatio
        pageViewController.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: pageViewHeight)
    }
    
    // 그라디언트 오버레이 설정
    func setupGradientOverlay() {
        let screenWidth = UIScreen.main.bounds.width
        let pageViewHeight = screenWidth * imageAspectRatio
        
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 195, width: screenWidth, height: 100)
        
        // 그라디언트 색상 (밝은 투명 -> 어두운 반투명)
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.4).cgColor
        ]
        gradientLayer.locations = [0.0, 1.0]
        
        // 페이지 뷰에 그라디언트 오버레이 추가
        pageViewController.view.layer.addSublayer(gradientLayer)
    }
    
    // 페이지 컨트롤 설정 (이미지 위에 오버레이)
    func setupPageControl() {
        let screenWidth = UIScreen.main.bounds.width
        let pageViewHeight = screenWidth / imageAspectRatio
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: pageViewHeight - 36, width: screenWidth, height: 30))
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.white
        pageControl.pageIndicatorTintColor = UIColor.white.withAlphaComponent(0.2)
        pageControl.currentPageIndicatorTintColor = UIColor.white
        
        pageControl.isUserInteractionEnabled = false
        
        // 페이지 컨트롤을 이미지 위에 오버레이
        pageViewController.view.addSubview(pageControl)
    }
    
    // 현재 페이지 인덱스에 맞는 뷰 컨트롤러를 반환
    func getViewControllerAtIndex(_ index: Int) -> ImageContentViewController? {
        if index >= images.count || index < 0 {
            return nil
        }
        
        let contentVC = ImageContentViewController()
        contentVC.imageName = images[index]
        contentVC.pageIndex = index
        return contentVC
    }
    
    // 다음 뷰 컨트롤러 제공 (스와이프)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ImageContentViewController
        var index = contentVC.pageIndex
        index += 1
        
        return getViewControllerAtIndex(index)
    }
    
    // 이전 뷰 컨트롤러 제공 (스와이프)
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let contentVC = viewController as! ImageContentViewController
        var index = contentVC.pageIndex
        index -= 1
        
        return getViewControllerAtIndex(index)
    }
    
    // 페이지 변경 시 호출
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            let currentVC = pageViewController.viewControllers![0] as! ImageContentViewController
            pageControl.currentPage = currentVC.pageIndex
        }
    }
}

#Preview {
    ImagePageViewController()
}
