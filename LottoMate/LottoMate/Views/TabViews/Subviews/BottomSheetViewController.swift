//
//  BottomSheetViewController.swift
//  LottoMate
//
//  Created by Mirae on 10/9/24.
//  ***** 바텀 시트가 아닌 부분 터치 되도록 수정 필요

import UIKit

final class BottomSheetViewController: UIViewController {
    enum BottomSheetViewState {
        case expanded
        case normal
        case hidden
    }
//    private lazy var dimmedView: UIView = {
//        let view = UIView()
//        view.backgroundColor = UIColor.black.withAlphaComponent(self.dimmedAlpha)
//        view.alpha = 0
//        return view
//    }()
    private lazy var bottomSheetView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = self.cornerRedius
        view.layer.cornerCurve = .continuous // 확인이 필요합니다.
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        return view
    }()
//    private let dragIndicatorView: UIView = {
//        let view = UIView()
//        view.backgroundColor = .gray30
//        view.layer.cornerRadius = 2
//        view.alpha = 0 // 확인이 필요합니다.
//        view.frame = CGRect(x: 0, y: 0, width: 40, height: 4)
//        return view
//    }()
    private var bottomSheetViewTopConstraint: NSLayoutConstraint!
    
    private var isViewLaidOut: Bool = false
    private var bottomSheetState: BottomSheetViewState = .normal
    // 열린 BottomSheet의 기본 높이를 지정하기 위한 프로퍼티
    var defaultHeight: CGFloat = 423 // 탭바 위로 나타나는 height
    var dimmedAlpha: CGFloat = 0.4 // 0.1 이하의 값도 설정가능한지 확인이 필요합니다. (0.08 / 8 %)
    var cornerRedius: CGFloat = 16
    // Bottom Sheet과 safe Area Top 사이의 최소값을 지정하기 위한 프로퍼티
    var bottomSheetPanMinTopConstant: CGFloat = 379
    // pannedGesture 활성화 여부
    var isPannedable: Bool = false
    // 드래그 하기 전에 Bottom Sheet의 top Constraint value를 저장하기 위한 프로퍼티
    private lazy var bottomSheetPanStartingTopConstant: CGFloat = bottomSheetPanMinTopConstant
    
    private let contentViewController: UIViewController
    
    init(contentViewController: UIViewController, defaultHeight: CGFloat, cornerRadius: CGFloat = 16, dimmedAlpha: CGFloat = 0.4, isPannedable: Bool = false) {
        self.contentViewController = contentViewController
        self.defaultHeight = defaultHeight
        self.cornerRedius = cornerRadius
        self.dimmedAlpha = dimmedAlpha
        self.isPannedable = isPannedable
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .custom
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        self.configureLayout()
//        self.configureDimmedTapGesture()
        
        if isPannedable {
            self.configureViewPannedGesture()
//            self.dragIndicatorView.alpha = 1
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.showBottomSheet(atState: .normal)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // 레이아웃이 완료된 후 safeAreaInsets와 tabBarHeight를 다시 계산하여 올바르게 적용
        if !isViewLaidOut {
            isViewLaidOut = true
            showBottomSheet(atState: .normal) // 처음 한 번만 레이아웃을 조정
        }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate { [weak self] _ in
            self?.showBottomSheet(atState: .normal)
        }
    }
    
    private func showBottomSheet(atState state: BottomSheetViewState) {
        let partiallyVisibleHeight = (view.safeAreaLayoutGuide.layoutFrame.height + view.safeAreaInsets.bottom) - 48
        let targetHeight: CGFloat

        switch state {
        case .expanded:
            targetHeight = bottomSheetPanMinTopConstant // 완전히 펼친 상태로 열기
        case .normal:
            targetHeight = partiallyVisibleHeight // partiallyVisibleHeight로 돌아가기
        case .hidden:
            targetHeight = partiallyVisibleHeight // hidden 대신 partiallyVisibleHeight에서 멈추도록 설정
        }

        // 애니메이션을 이용해 바텀 시트 높이 조정
        UIView.animate(withDuration: 0.3) {
            self.bottomSheetViewTopConstraint.constant = targetHeight
            self.view.layoutIfNeeded()
        }
    }
}

// MARK: Configure
extension BottomSheetViewController {
    private func configureUI() {
        view.addSubview(bottomSheetView)
//        view.addSubview(dimmedView)
//        view.addSubview(dragIndicatorView)
        
        addChild(contentViewController)
        bottomSheetView.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
        bottomSheetView.clipsToBounds = true
    }
    
    private func configureLayout() {
//        dimmedView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dimmedView.topAnchor.constraint(equalTo: view.topAnchor),
//            dimmedView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
//            dimmedView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
//            dimmedView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
//        ])
        
        // MARK: Layout 깨짐 경고를 제거하고자 하는 경우 bottomSheetView의 heightAnchor 값을 지정하면 해결된다.
        bottomSheetView.translatesAutoresizingMaskIntoConstraints = false
        let topConstant = view.safeAreaInsets.bottom + view.safeAreaLayoutGuide.layoutFrame.height
        bottomSheetViewTopConstraint = bottomSheetView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstant)
        NSLayoutConstraint.activate([
            bottomSheetView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            bottomSheetView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            bottomSheetView.bottomAnchor.constraint(equalTo: view.bottomAnchor), // MARK: 이부분으로 인해 Layout 깨짐 경고가 뜬다
            bottomSheetViewTopConstraint,
        ])
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: bottomSheetView.topAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: bottomSheetView.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: bottomSheetView.trailingAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: bottomSheetView.bottomAnchor)
        ])
        
//        dragIndicatorView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            dragIndicatorView.widthAnchor.constraint(equalToConstant: 60),
//            dragIndicatorView.heightAnchor.constraint(equalToConstant: dragIndicatorView.layer.cornerRadius * 2),
//            dragIndicatorView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
//            dragIndicatorView.bottomAnchor.constraint(equalTo: bottomSheetView.topAnchor, constant: 12)
//        ])
    }
    
//    private func configureDimmedTapGesture() {
//        let dimmedTap = UITapGestureRecognizer(target: self, action: #selector(dimmedViewTapped(_:)))
//        dimmedView.addGestureRecognizer(dimmedTap)
//        dimmedView.isUserInteractionEnabled = true
//    }
    
    private func configureViewPannedGesture() {
        // Pan Gesture Recognizer를 view controller의 view에 추가하기 위한 코드
        let viewPan = UIPanGestureRecognizer(target: self, action: #selector(viewPanned(_:)))
        
        // 기본적으로 iOS는 터치가 드래그하였을 때 딜레이가 발생함
        // 우리는 드래그 제스쳐가 바로 발생하길 원하기 때문에 딜레이가 없도록 아래와 같이 설정
        viewPan.delaysTouchesBegan = false
        viewPan.delaysTouchesEnded = false
        view.addGestureRecognizer(viewPan)
    }
}

// MARK: Gesture
extension BottomSheetViewController {
//    @objc private func dimmedViewTapped(_ tapRecognizer: UITapGestureRecognizer) {
////        self.hideBottomSheetAndGoBack()
//        showBottomSheet(atState: .normal)
//    }
    
    // 해당 메소드는 사용자가 view를 드래그하면 실행됨
    @objc private func viewPanned(_ panGestureRecognizer: UIPanGestureRecognizer) {
        let translation = panGestureRecognizer.translation(in: view)
        
        let velocity = panGestureRecognizer.velocity(in: view)
        
        switch panGestureRecognizer.state {
        case .began:
            bottomSheetPanStartingTopConstant = bottomSheetViewTopConstraint.constant
        case .changed:
            if bottomSheetPanStartingTopConstant + translation.y > bottomSheetPanMinTopConstant {
                bottomSheetViewTopConstraint.constant = bottomSheetPanStartingTopConstant + translation.y
            }
            
//            dimmedView.alpha = dimAlphaWithBottomSheetTopConstraint(value: bottomSheetViewTopConstraint.constant)
        case .ended:
            if velocity.y > 1500 {
//                hideBottomSheetAndGoBack()
                showBottomSheet(atState: .normal)
                return
            }
            
            let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
            let bottomPadding = view.safeAreaInsets.bottom
            let defaultPadding = safeAreaHeight+bottomPadding - defaultHeight
            
            let nearestValue = nearest(to: bottomSheetViewTopConstraint.constant, inValues: [bottomSheetPanMinTopConstant, defaultPadding, safeAreaHeight + bottomPadding])
            
            if nearestValue == bottomSheetPanMinTopConstant {
                showBottomSheet(atState: .expanded)
            } else if nearestValue == defaultPadding {
                // Bottom Sheet을 .normal 상태로 보여주기
                showBottomSheet(atState: .normal)
            } else {
                // Bottom Sheet을 숨기고 현재 View Controller를 dismiss시키기
//                hideBottomSheetAndGoBack()
                showBottomSheet(atState: .normal)
            }
        default:
            break
        }
    }
}

extension BottomSheetViewController {
    private func hideBottomSheetAndGoBack() {
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        bottomSheetViewTopConstraint.constant = safeAreaHeight + bottomPadding
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseIn, animations: {
//            self.dimmedView.alpha = 0.0
            self.view.layoutIfNeeded()
        }) { _ in
            if self.presentingViewController != nil {
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
    
    //주어진 CGFloat 배열의 값 중 number로 주어진 값과 가까운 값을 찾아내는 메소드
    private func nearest(to number: CGFloat, inValues values: [CGFloat]) -> CGFloat {
        guard let nearestVal = values.min(by: { abs(number - $0) < abs(number - $1) })
        else { return number }
        return nearestVal
    }
    
    private func dimAlphaWithBottomSheetTopConstraint(value: CGFloat) -> CGFloat {
        let fullDimAlpha: CGFloat = self.dimmedAlpha
        
        let safeAreaHeight = view.safeAreaLayoutGuide.layoutFrame.height
        let bottomPadding = view.safeAreaInsets.bottom
        
        // bottom sheet의 top constraint 값이 fullDimPosition과 같으면
        // dimmer view의 alpha 값이 dimmedAlpha가 되도록 합니다
        let fullDimPosition = (safeAreaHeight + bottomPadding - defaultHeight) / 2
        
        // bottom sheet의 top constraint 값이 noDimPosition과 같으면
        // dimmer view의 alpha 값이 0.0이 되도록 합니다
        let noDimPosition = safeAreaHeight + bottomPadding
        
        // Bottom Sheet의 top constraint 값이 fullDimPosition보다 작으면
        // 배경색이 가장 진해진 상태로 지정해줍니다.
        if value < fullDimPosition {
            return fullDimAlpha
        }
        
        // Bottom Sheet의 top constraint 값이 noDimPosition보다 크면
        // 배경색이 투명한 상태로 지정해줍니다.
        if value > noDimPosition {
            return 0.0
        }
        
        // 그 외의 경우 top constraint 값에 따라 0.0과 dimmedAlpha 사이의 alpha 값이 Return되도록 합니다
        return fullDimAlpha * (1 - ((value - fullDimPosition) / (noDimPosition - fullDimPosition)))
    }
    
    @objc private func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        let translation = recognizer.translation(in: view)
        let velocity = recognizer.velocity(in: view)

        // 현재 화면의 높이와 안전 영역 높이 계산
        let partiallyVisibleHeight = (view.safeAreaLayoutGuide.layoutFrame.height + view.safeAreaInsets.bottom) - 100 // partiallyVisibleHeight
        let topConstraintLimit = partiallyVisibleHeight

        switch recognizer.state {
        case .changed:
            // panning 중일 때 바텀 시트를 끌어올리거나 내리기
            var newTopConstant = bottomSheetViewTopConstraint.constant + translation.y

            // newTopConstant가 partiallyVisibleHeight 이하로 내려가지 않도록 제한
            if newTopConstant > topConstraintLimit {
                newTopConstant = topConstraintLimit
            }

            // 바텀 시트가 화면 위쪽으로 지나치게 올라가지 않도록 제한
            newTopConstant = min(newTopConstant, bottomSheetPanMinTopConstant)

            // 제스처를 통해 이동한 만큼의 값을 constraint에 반영
            bottomSheetViewTopConstraint.constant = newTopConstant
            recognizer.setTranslation(.zero, in: view)

        case .ended:
            // panning이 끝난 후 바텀 시트를 펼칠지, partiallyVisibleHeight로 돌아갈지 결정
            let shouldExpand = velocity.y < 0 || bottomSheetViewTopConstraint.constant < (view.frame.height * 0.75)
            if shouldExpand {
                showBottomSheet(atState: .expanded) // 완전히 펼치기
            } else {
                showBottomSheet(atState: .normal) // 다시 partiallyVisibleHeight로 돌아가기
            }

        default:
            break
        }
    }
}
