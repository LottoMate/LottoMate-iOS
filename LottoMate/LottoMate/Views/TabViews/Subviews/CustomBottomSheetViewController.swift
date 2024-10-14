//
//  Custom BottomSheetViewController.swift
//  LottoMate
//
//  Created by Mirae on 10/14/24.
//

import UIKit

class CustomBottomSheetViewController: UIViewController {
    
    private let contentViewController: UIViewController
    private let minHeight: CGFloat
    private let maxHeight: CGFloat
    
    private var bottomConstraint: NSLayoutConstraint?
    private var heightConstraint: NSLayoutConstraint?
    
    init(contentViewController: UIViewController, minHeight: CGFloat, maxHeight: CGFloat) {
        self.contentViewController = contentViewController
        self.minHeight = minHeight
        self.maxHeight = maxHeight
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupPanGesture()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.clipsToBounds = true
        
        addChild(contentViewController)
        view.addSubview(contentViewController.view)
        contentViewController.didMove(toParent: self)
        
        contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentViewController.view.topAnchor.constraint(equalTo: view.topAnchor),
            contentViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        view.addGestureRecognizer(panGesture)
    }
    
    @objc private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        
        switch gesture.state {
        case .changed:
            let newHeight = max(minHeight, min(maxHeight, heightConstraint?.constant ?? 0 - translation.y))
            heightConstraint?.constant = newHeight
            view.superview?.layoutIfNeeded()
        case .ended:
            let velocity = gesture.velocity(in: view)
            if velocity.y < 0 {
                // Swiped up
                animateBottomSheet(to: maxHeight)
            } else {
                // Swiped down
                animateBottomSheet(to: minHeight)
            }
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: view)
    }
    
    private func animateBottomSheet(to height: CGFloat) {
        UIView.animate(withDuration: 0.3) {
            self.heightConstraint?.constant = height
            self.view.superview?.layoutIfNeeded()
        }
    }
    
    func addToParent(_ parentViewController: UIViewController) {
        parentViewController.addChild(self)
        parentViewController.view.addSubview(view)
        didMove(toParent: parentViewController)
        
        view.translatesAutoresizingMaskIntoConstraints = false
        bottomConstraint = view.bottomAnchor.constraint(equalTo: parentViewController.view.bottomAnchor)
        heightConstraint = view.heightAnchor.constraint(equalToConstant: minHeight)
        
        NSLayoutConstraint.activate([
            view.leadingAnchor.constraint(equalTo: parentViewController.view.leadingAnchor),
            view.trailingAnchor.constraint(equalTo: parentViewController.view.trailingAnchor),
            bottomConstraint!,
            heightConstraint!
        ])
    }
}
